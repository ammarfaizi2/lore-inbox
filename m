Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbULFIyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbULFIyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 03:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbULFIyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 03:54:41 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:49884 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261409AbULFIyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 03:54:39 -0500
Date: Mon, 6 Dec 2004 01:54:06 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Zoltan Boszormenyi <zboszor@freemail.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: CD-ROM problem on x86-64
In-Reply-To: <41B33B4A.5040104@freemail.hu>
Message-ID: <Pine.LNX.4.61.0412060141530.1036@montezuma.fsmlabs.com>
References: <41A84875.2030505@freemail.hu> <20041129175851.0b7ed213.akpm@osdl.org>
 <41B33B4A.5040104@freemail.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zoltan,

On Sun, 5 Dec 2004, Zoltan Boszormenyi wrote:

> Finally, I got a little time to try other kernels than the
> official Fedora erratas. I compiled 2.6.10-rc3, applied the
> time-sliced-cfq-#2 io scheduler patch from Jens Axboe and updated
> the linuxconsole.sf.net multiconsole patch to work with 2.6.10-rc3,
> I depend on this functionality on my machine, my wife works on the
> machine or our children watch some cartoon or play games, etc, while
> I hack... :-)
> 
> I attached the full boot log for both kernel-2.6.9-1.681 (also
> customized with the multiconsole patch) and 2.6.10-rc3.
> The uptime is now more than 2 hours with the new kernel, so far
> I haven't experienced similar problem with it. I played an AVI
> off the harddisk and recompiled the xorg-x11 src.rpm at the same
> time to create I/O stress. No problem with /dev/hda.

Thanks for following up with your current status.

> What I miss are my removable devices. How to convince HAL daemon
> to keep /media/floppy and /media/cdrecorder? Or which patches should
> I apply from the Fedora kernel src.rpm? I created /mnt/cdrom and
> tried mounting /dev/hdc there (as root) but the mount hung...
> The kernel-2.6.9-1.681 Fedora kernel is basically 2.6.9-ac10, is there
> something in there what is not in 2.6.10-rc3 and a relevant fix to this?
> I am still on FC3/x86-64...

Ooh that would take a while to find the exact fix =) I'm sure there should 
be a Fedora kernel update fairly soon.

Thanks,
	Zwane

