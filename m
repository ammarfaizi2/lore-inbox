Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKRQEi>; Sat, 18 Nov 2000 11:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbQKRQET>; Sat, 18 Nov 2000 11:04:19 -0500
Received: from [212.172.23.17] ([212.172.23.17]:3588 "EHLO mail.plan9.de")
	by vger.kernel.org with ESMTP id <S129152AbQKRQEI>;
	Sat, 18 Nov 2000 11:04:08 -0500
Date: Sat, 18 Nov 2000 16:32:58 +0100
From: Marc Lehmann <pcg@goof.com>
To: linux-kernel@vger.kernel.org
Subject: reordering pci interrupts?
Message-ID: <20001118163258.A1643@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux version 2.2.17 (root@cerebro) (gcc version pgcc-2.95.2 19991024 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a motherboard with a broken bios that is unable to set interrupts
correctly, i.e. it initializes the devices corerctly but swaps the
interrupts for slot1/slot3 and slot2/slot4.

Now, is there a way to forcefully re-order the pci-interrupts? I do not
have an io-apic (thus no pirq=xxx), and I tried to poke the interrupt
values directly into /proc/bus/pic/*/*, but the kernel has it's own idea.

Thanks a lot for any info (I guess I'll just patch the kernel).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
