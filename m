Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268897AbTBSNpw>; Wed, 19 Feb 2003 08:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268898AbTBSNpw>; Wed, 19 Feb 2003 08:45:52 -0500
Received: from 212-170-21-172.uc.nombres.ttd.es ([212.170.21.172]:20929 "EHLO
	omega.resa.es") by vger.kernel.org with ESMTP id <S268897AbTBSNpv>;
	Wed, 19 Feb 2003 08:45:51 -0500
Date: Wed, 19 Feb 2003 14:55:45 +0100
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] PDC20269 on smp and up
Message-ID: <20030219135545.GA5328@omega.resa.es>
Mail-Followup-To: piotr, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Pedro Larroy <piotr@omega.resa.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I can't get two pci PDC20269 boards (Promise Ultra 133 tx2)
to run stably neither on a smp 
nor in a up box. The kernel hangs with no oops and no message is
displayed. 

I've gotten to run one of the PDC boards in a up box well with 2.4.18 and
2.4.20*-ac. But in the smp
box, only with latter -ac kernels or 2.5 kernel will work ok. Although
with last -ac patch for 2.4.21-pre4, I can't boot it in the smp box,
because a bug on amd74xx. 

I'm really kernelnewbie so, I will aprecieate any hints in how to start
looking for the bug, and I will apreciate your thoughts about if ide
drivers are too difficult for a kernel beginner. I'm running the kernel
on the smp box with nmi_watchdog=2.

I have tried to run with nmi_watchdog=2 and =1 on the up box, but I still
don't see any NMI interrupts in /proc/interrupts. The processor is AMD XP
1600+ model 6, family 6.

Any hints in what to do will be nice. 

Regards.
-- 
O   _____________________________________________________________   O
|  /-| Pedro Larroy Tovar. PiotR | http://omega.resa.es/piotr  |-\  |
| /--|            No MS-Office attachments please.             |--\ |
o-|--|              e-mail: piotr@omega.resa.es                |--|-o 
   \-|   finger piotr@omega.resa.es for public key and info    |-/  
    -------------------------------------------------------------
