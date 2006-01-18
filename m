Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbWARAuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWARAuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWARAuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:50:50 -0500
Received: from rtr.ca ([64.26.128.89]:54421 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932520AbWARAut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:50:49 -0500
Message-ID: <43CD90E3.70906@rtr.ca>
Date: Tue, 17 Jan 2006 19:50:43 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Sebastian Kuzminsky <seb@highlab.com>
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata_mv important note
References: <43CD07D5.30302@pobox.com> <E1EytdC-0006DE-IS@highlab.com> <200601171734.25598.arekm@pld-linux.org> <E1EyxRD-0007Nd-U5@highlab.com>
In-Reply-To: <E1EyxRD-0007Nd-U5@highlab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Kuzminsky wrote:
>
> I'm using:
> 
> 0000:02:01.0 IDE interface: Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
> 
> I'm running the stock 2.6.15 kernel & the in-kernel driver.  I have four
> disks on this controller.  The controller and disks seem perfectly stable,
> I've been running four parallel "badblocks -n" processes (one on each
> disk) for almost 5 days now.  Using the disks as PVs in LVM works fine,
> and building a RAID-6 out of them also works fine.
> 
> But when I build a RAID-6 out of them, and use the array as a PV
> for LVM, the system locks up within seconds (no errors, no sysrq,
> no CapsLock-blinky, no network-pingy).  This behavior is perfectly
> repeatable.
> 
> The problem goes away and everything works if I turn on all the debugging
> options in the kernel config (but I dont get any debug output from
> the kernel).
> 
> Arkadiusz, if possible, please see if you can replicate my hang.

I will try and reproduce and fix this issue when my Marvell RAID system
arrives here in a week or two.

Cheers
