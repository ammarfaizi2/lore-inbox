Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132786AbRAPUkT>; Tue, 16 Jan 2001 15:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132783AbRAPUkJ>; Tue, 16 Jan 2001 15:40:09 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:6407 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S132781AbRAPUjv>; Tue, 16 Jan 2001 15:39:51 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95199@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Dr. Kelsey Hudson'" <kernel@blackhole.compendium-tech.com>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 15:35:25 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Of course that would be better. The only complaint I have with such a
> system is that of backwards compatibility...as long as the legacy device
> names are still supported i would have no problem with it at all. 
> 
> however, this brings up an interesting question: what happens if two disks
> (presumably from two different machines) have the same disk label? what
> happens then? for instance, i have several linux machines both at my
> workplace and my home. if for some reason one of these machines dies due
> to hardware failure and i want to get stuff off the drives, i put the disk
> containing the /home partition on the failed machine into a working
> machine and reboot. What /home gets mounted then? the original /home or
> the new one from the dead machine? (and don't say end users wouldn't
> possibly do that... if they are adding hardware into their systems this is
> by no means beyond their capabilities)
> 
> at least with physical device nodes i can say 'computer, you will mount
> this partition on this mountpoint!' and be done with it.
	[Venkatesh Ramamurthy]  You are getting my point exactly. This was
my argument from the first, we should have a efficient mechanism to mount
partitions 

> so tell me then, how would one discern between two partitions with the
> same label?
	[Venkatesh Ramamurthy]  If the OS detects two partitions of the same
name , either dont mount both , but display an error  (or) mount the first
one it finds ( this is not a good idea but) 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
