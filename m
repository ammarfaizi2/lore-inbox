Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbWEaVzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWEaVzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWEaVzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:55:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:63719 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965139AbWEaVzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:55:12 -0400
Date: Wed, 31 May 2006 23:54:45 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Janos Haar <djani22@netcenter.hu>
cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: XFS related hang (was Re: How to send a break? - dump from frozen
 64bit linux)
In-Reply-To: <00f501c68488$4d10c080$1800a8c0@dcccs>
Message-ID: <Pine.LNX.4.61.0605312353530.30170@yvahk01.tjqt.qr>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs> <20060527234350.GA13881@voodoo.jdc.home>
 <004501c68225$00add170$1800a8c0@dcccs> <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com>
 <01d801c6827c$fba04ca0$1800a8c0@dcccs> <01a801c683d2$e7a79c10$1800a8c0@dcccs>
 <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu>
 <1149038431.21827.20.camel@localhost.localdomain>
 <20060531143849.C478554@wobbly.melbourne.sgi.com> <00f501c68488$4d10c080$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hey, i think i found something.
>My quota on my huge device is broken.

That should not be a problem. I ran into that "problem" too but had no 
lockups back then (2.6.16-rc1).

>(inferno   -- 18014398504855404       0       0        18446744073709551519
>0     0)
>I cant found a way to re-initialize it.

Reinit:

quotaoff /mntpt
umount /mntpt
mount /mntpt

>But anyway, at this point i dont need it, trying to disable the quota usage.
>We will see....


Jan Engelhardt
-- 
