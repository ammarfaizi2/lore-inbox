Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129739AbRBFIqW>; Tue, 6 Feb 2001 03:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131705AbRBFIqM>; Tue, 6 Feb 2001 03:46:12 -0500
Received: from amzei.pcnet.ro ([213.154.131.250]:48391 "EHLO mail.icafe.ro")
	by vger.kernel.org with ESMTP id <S129739AbRBFIqF>;
	Tue, 6 Feb 2001 03:46:05 -0500
Date: Tue, 6 Feb 2001 11:41:56 +0200 (EET)
From: <solics@icafe.ro>
To: Wenzhuo Zhang <wenzhuo@zhmail.com>
cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] mongo.sh 2.2.18: do_try_to_free_pages failed
 ...
In-Reply-To: <20010206102048.A816@zhmail.com>
Message-ID: <Pine.LNX.4.21.0102061140530.16736-100000@mail.icafe.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is a bad RAM problem, or insufficient RAM (slightly less possible)


On Tue, 6 Feb 2001, Wenzhuo Zhang wrote:

> 
> Hi,
> 
> I got the VM error "VM: do_try_to_free_pages failed for mongo_read..."
> and then I couldn't log into the system, when stress testing
> reiserfs+raid0 setup on a 2.2.18 box using the reiserfs benchmark
> mongo.sh. The problem was reporduceable on each run of mongo.sh.
> 
> ./mongo.sh reiserfs /dev/md0 /mnt/testfs raid0-rfs 3
> 
> Thinking the raid code might cause the problem, I tested on reiserfs
> only, but I got the same error message. Later, I found the same
> problem running mongo.sh on an ext2 partition (stock kernel without
> any patches).
> 
> I guess this problem is not reiserfs specific. What can I do now to
> solve the problem?
> 
> Here is the hardware configuration of my test box:
> PIII 600, 256M, Adaptec AIC-7896 SCSI controller, two Quantum SCSI
> disks.
> 
> Regards,
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
