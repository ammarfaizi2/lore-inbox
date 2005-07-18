Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVGRUMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVGRUMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 16:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGRUMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 16:12:51 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:27338 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261691AbVGRUMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 16:12:51 -0400
Date: Mon, 18 Jul 2005 22:12:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Richard Gooch <rg+lkml0@safe-mbox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
In-Reply-To: <17115.55954.942676.450479@mailix.sanjose.privnets>
Message-ID: <Pine.LNX.4.61.0507182202400.16975@yvahk01.tjqt.qr>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org>
 <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org>
 <20050623045959.GB10386@kroah.com> <17115.55954.942676.450479@mailix.sanjose.privnets>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Greg KH writes:
>> I do care about this, please don't think that.  But here's my reasoning
>> for why it needs to go:
>[...]
>> 	- original developer of devfs has publicly stated udev is a
>> 	  replacement.
>
>Well, that's news to me!

What is more news to me: 
    ( http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ )
    Q: Why was devfs marked OBSOLETE if udev is not finished yet?
    A: To quote Al Viro (Linux VFS kernel maintainer):
==> - the devfs maintainer/author disappeared and stoped maintaining the code

So, if you allow the question, where [t.h.] have you been in the meantime?

>> 	- clutter and mess
>In the eye of the beholder.
It's kernel code - I think the point is valid.

>> 	- code is broken and unfixable
>No proof. Never say never...

*thumbs up* You could just become the maintainer of ndevfs. :)


Something's wondering me, though:
FreeBSD "just" (5.0) introduced devfs, so either they are behind The Facts 
(see udev FAQ), or devfs (anylinux/anybsd) is not so bad after all.



Jan Engelhardt
-- 
