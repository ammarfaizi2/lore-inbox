Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132983AbRAQPd2>; Wed, 17 Jan 2001 10:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132967AbRAQPdT>; Wed, 17 Jan 2001 10:33:19 -0500
Received: from copland.udel.edu ([128.175.13.92]:34769 "EHLO copland.udel.edu")
	by vger.kernel.org with ESMTP id <S131880AbRAQPdN>;
	Wed, 17 Jan 2001 10:33:13 -0500
Date: Wed, 17 Jan 2001 10:33:06 -0500 (EST)
From: Mike Porter <mike@UDel.Edu>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
cc: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <Pine.LNX.4.21.0101161221530.17397-100000@sol.compendium-tech.com>
Message-ID: <Pine.SOL.4.31.0101171029270.12-100000@copland.udel.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
>
> so tell me then, how would one discern between two partitions with the
> same label?

On OS/390, the operator gets a message listing the devices with
duplicate labels.  Unfortunately, the message requests that the
operator enter the physical address(es) of the devices to bring
offline...not the address(es) of the devices that should be used.

Duplicate labels -> human interaction...

Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
