Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTCEFQd>; Wed, 5 Mar 2003 00:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264820AbTCEFQd>; Wed, 5 Mar 2003 00:16:33 -0500
Received: from isdn245.s.netic.de ([212.9.162.245]:10889 "EHLO solfire")
	by vger.kernel.org with ESMTP id <S264711AbTCEFQb>;
	Wed, 5 Mar 2003 00:16:31 -0500
Date: Wed, 05 Mar 2003 06:26:25 +0100 (MET)
Message-Id: <20030305.062625.41626004.mccramer@s.netic.de>
To: linux-kernel@vger.kernel.org
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <20030305024446.GA13870@merlin.emma.line.org>
References: <20030305024446.GA13870@merlin.emma.line.org>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org
Subject: [2.4.20]: Question about myst. interrupt thingy
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 System:
 generic Linux 2.4.20 (dRock 1.60 based with heavy changes)
 gcc 2.95.3
 Athlon XP 2400+
 256MB DDR RAM (Samsung)
 EPoX 8K5A3+ (VIA KT333)
 Sound onboard (VIA8233)
 Radeon 7500 AGP (made by Sapphire) 

 Interrupts as follows:
            CPU0       
   0:    3617891          XT-PIC  timer
   1:      27017          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:      55271          XT-PIC  usb-uhci, VIA8233
   9:          0          XT-PIC  usb-uhci
  10:    3045481          XT-PIC  usb-uhci, radeon@PCI:1:0:0
  11:         30          XT-PIC  sym53c8xx
  14:     505263          XT-PIC  ide0
  15:      74476          XT-PIC  ide1
 NMI:          0 
 ERR:          7
 
 
 Now, I got the following message whiel booting the kernel:
 
 PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
 
 If I am using pci=biosirq I got the same mesage without "Please try
 using pci=biosirq".
 
 What is THIS? What is that mean?
 Anything serious?
 
 Since my box has some "mysterious"  effects (locks for minutes as it
 seems of being under heaviest load, than unlocks again. Sometimes
 programs being "stable for years" (bash ie.) crashes and core dump.) I
 would be very interesting, whether this has something to do with it.
 
 Any help is very appreciated !
 Thank you very much in advance.
 
 Kind regards,
 Meino Cramer

