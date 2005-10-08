Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVJHTbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVJHTbg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 15:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVJHTbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 15:31:36 -0400
Received: from xenotime.net ([66.160.160.81]:13476 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751110AbVJHTbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 15:31:35 -0400
Date: Sat, 8 Oct 2005 12:31:31 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Simen Thoresen <simentt@dolphinics.no>
Cc: devesh28@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Issues in Booting kernel 2.6.13
Message-Id: <20051008123131.41d85d45.rdunlap@xenotime.net>
In-Reply-To: <43481D0F.9020407@dolphinics.no>
References: <309a667c0510052216n784e229ei69b3a3a2a9e93f4b@mail.gmail.com>
	<20051006190806.388289ff.rdunlap@xenotime.net>
	<43481D0F.9020407@dolphinics.no>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Oct 2005 21:25:03 +0200 Simen Thoresen wrote:

> Hi Randy,
> 
> Randy.Dunlap wrote:
> > On Thu, 6 Oct 2005 10:46:37 +0530 devesh sharma wrote:
> > 
> > 
> >>Hi all,
> >>I have compiled 2.6.13 kernel on a opteron machine with 1 GB physical
> >>memory, Whole compilation gose well but at the last step
> >>make install I am getting a warning
> >>WARNING: No module mptbase found for kernel 2.6.13, continuing anyway
> >>WARNING: No module mptscsih found for kernel 2.6.13, continuing anyway
> > 
> > 
> > If you need mpt drivers, there were some changes in the
> > FUSION MPT driver options that may be causing them not to be
> > built for you as you were expecting.
> 
> I ran into this (2.6.13.3) on Friday as well, but I have not yet examined it 
> in detail.
> 
> Do you have any pointers to the relevant postings or information?

No, I just recall seeing a few other problem reports and answers about it,
and then I compared the 2.6.12 and 2.6.13 .config files following
'make defconfig'.

> I've used the 'mkinitrd' tool to generate a 'proper' initrd, and I see both 
> mptbase and mptscsih loading, but mptscsih never picks up any actual 
> controllers or disks. Thus the same problem on my system.
> 
> To me, this signifies that RHs mkinitrd is broken for this kernel, but I 
> don't know the details of why yet.

so maybe someone from Red Hat can answer/clarify.

> Yours,
> -S
> 
> 
> >>now when I boot my kernel, panic is received
> >>Booting the kernel.
> >>Red Hat nash version 4.1.18 starting
> >>mkrootdev: lable / not found
> >>mount: error 2 mounting ext3
> >>mount: error 2 mounting none
> >>switchroot: mount failed : 22
> >>umount : /initrd/dev failed : 22
> >>kernel panic - not syncing : Attempted to kill init
> >>
> >>What could be the problem?
> >>I have RHEL 4 base release already installed on which I have compiled
> >>this image.


---
~Randy
