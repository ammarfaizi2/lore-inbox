Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSJQR6Z>; Thu, 17 Oct 2002 13:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbSJQR6Z>; Thu, 17 Oct 2002 13:58:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261934AbSJQR6Y>;
	Thu, 17 Oct 2002 13:58:24 -0400
Date: Thu, 17 Oct 2002 11:04:26 -0700
From: Dave Olien <dmo@osdl.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.43 disk repartitioning problems
Message-ID: <20021017110426.D3841@acpi.pdx.osdl.net>
References: <20021007204414.GD7428@atrey.karlin.mff.cuni.cz> <Pine.GSO.4.21.0210071723200.29030-100000@weyl.math.psu.edu> <20021017105205.C3841@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017105205.C3841@acpi.pdx.osdl.net>; from dmo@osdl.org on Thu, Oct 17, 2002 at 10:52:05AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I made a typo in the message below.  The partitioning issue appears
in linux 2.5.43. (NOT 2.4.3 ..)


On Thu, Oct 17, 2002 at 10:52:05AM -0700, Dave Olien wrote:
> 
> Al,
> 
> I'm working on the Mylex DAC960 device driver, bring in up to date
> with the new block and dma interfaces.  I've been posting patches on
> occasion.  I've also noticed you updating the driver when you make changes
> to the gendisk kernel interfaces.   Those updates are very helpful.
> 
> I've noticed in 2.4.3 at least, that some changes to disk partitions
> aren't noticed until you reboot.  The same problem is seen with aacraid.
> I don't THINK this is a driver issue.  But, I might have missed something.  
> 
> I tried repartitioning two disks.  On the first disk, I used fdisk
> to split a single large partition into four smaller ones.  Afterwards,
> the first partition on that drive was still accessible.  But I couldn't
> access the three new partitions.  I didn't test to see if the first
> partition had been reduced in size.  Rebooting made the new partitions
> accessible.
> 
> In the second case, I split an unpartitioned drive into four partitions.
> None of the new partitions were accessible until I rebooted.
> 
> Is this still a work in progress, or is there some driver hook I've missed?
> 
> Thanks!
> 
> Dave Olien
> Open Source Development Lab
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
