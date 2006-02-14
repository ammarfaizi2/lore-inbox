Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030519AbWBNIyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbWBNIyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbWBNIyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:54:51 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:45616 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030519AbWBNIyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:54:50 -0500
Date: Tue, 14 Feb 2006 09:54:47 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: Random reboots
Message-ID: <20060214085446.GH3209@harddisk-recovery.com>
References: <20060213210435.GC16566@tau.solarneutrino.net> <20060213211044.066CE5E401E@latitude.mynet.no-ip.org> <20060213212243.GE16566@tau.solarneutrino.net> <7c3341450602131332x2fcd7d8co@mail.gmail.com> <20060213213929.GG16566@tau.solarneutrino.net> <20060213214956.GH16566@tau.solarneutrino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213214956.GH16566@tau.solarneutrino.net>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 04:49:57PM -0500, Ryan Richter wrote:
> On Mon, Feb 13, 2006 at 04:39:29PM -0500, ryan wrote:
> > It runs Debian Sarge for AMD64.  I have lots of other machines, but only
> > this one gets the reboots.  None of the others have SCSI, and none are
> > dual-CPU with memory on both nodes, just to name two obvious things
> > different on this machine.
> 
> Thinking about this some more...  My home desktop also is a dual opteron
> with memory on both nodes and SCSI, but it hasn't had any reboots.  The
> machine with the reboot trouble uses RAID5+LVM, unlike my desktop.  Also
> it's an NFS server, but I have another machine (single-cpu pentium 4, no
> SCSI etc.) that's an NFS server without reboots.  But none of the other
> machines have RAID or LVM.

We recently had such an issue with a dual AMD64 machine rebooting at
mke2fs. It turned out it was a faulty power supply. After we changed
the power supply, everything ran smooth again.

You could start to test by powering your drives from an old AT-style
power supply leaving more "juice" for the main board and CPUs.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
