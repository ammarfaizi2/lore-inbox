Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbQJ0KZf>; Fri, 27 Oct 2000 06:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129794AbQJ0KZR>; Fri, 27 Oct 2000 06:25:17 -0400
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:16132 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S129636AbQJ0KZJ>; Fri, 27 Oct 2000 06:25:09 -0400
Date: Fri, 27 Oct 2000 11:24:49 +0100 (BST)
From: Tim <tim@parrswood.manchester.sch.uk>
To: linux-kernel@vger.kernel.org
Subject: IDE + RAID + SMP + PIII crashes
Message-ID: <Pine.LNX.4.21.0010271036120.26729-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a number of machines (on 2 different motherboards) that if I run
2.4 on hang with an NMI error about 2/3's of the way though boot (about
were crond starts on redhat 6.2). 

2 of the machines are based on Supermicro P6DBEs the other is based on a
Gigabyte GA-6BXD. I am using the onboard ide and also have tried a Promise
20262. There are RAID 0 and 1 arrays on the manchines. 

The exact hardware specs are:
Supermicro P6DBE
2x P3 650
512Mb SDRAM
2x ST310212A (mirrored)
2x Maxtor 53073U6 (Striped) on a Promise 20262

Gigabyte GA-6BXD
2x P3 650
256Mb SDRAM
2x Westen Digitals (model unknown as the machine is at home and I'm not)

I have posted a decoded oops sometime ago, I can generate another one
agaist a current test kernel (the latest I have tried is test9)

I can test experimental / unstable / eat your fs patches on the gigabyte
machine, the Supermicro boxes are production machines.

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X   
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
                                   ^^-^^

"First they ignore you. Then they laugh at you.
   Then they fight you. Then you win." - Gandhi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
