Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWC0GRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWC0GRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 01:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWC0GRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 01:17:45 -0500
Received: from xenotime.net ([66.160.160.81]:44745 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750740AbWC0GRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 01:17:44 -0500
Date: Sun, 26 Mar 2006 22:19:52 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Linda Walsh <lkml@tlinx.org>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: Block I/O Schedulers: Can they be made selectable/device?
 @runtime?
Message-Id: <20060326221952.6f0e20a2.rdunlap@xenotime.net>
In-Reply-To: <442759FB.8090309@tlinx.org>
References: <4426377C.7000605@tlinx.org>
	<200603260706.k2Q76thB030947@turing-police.cc.vt.edu>
	<442759FB.8090309@tlinx.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006 19:20:27 -0800 Linda Walsh wrote:

> Valdis.Kletnieks@vt.edu wrote:
> > Hasn't been for quite some time. 
> > From my /etc/rc.local:
> >   
> Great...the file "Documentation/as_iosched.txt"  is apparently
> out of date.

What kernel version are you looking at?
That file is now Documentation/block/as_iosched.txt .


> > echo cfq > /sys/block/hda/queue/scheduler
> > echo noop > /sys/block/hdb/queue/scheduler
> >
> > (hda is a real disk with ext3 partitions on it, hdb is a DVD/CD/RW that almost
> > always has exactly one process reading or writing to it at a given time, so doing
> > things in the order requested is just fine).
> >
> > Simple enough? ;)
> >   
> ---
>     Sounds fine.  I don't suppose it's too much to ask, but where should
> should I have found the updated information? :-)

Patches accepted... Please summarize what you have found, even if not in
patch format (and I'll make it a patch).

---
~Randy
