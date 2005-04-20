Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVDTGaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVDTGaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 02:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVDTGaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 02:30:13 -0400
Received: from ns.amrita.ac.in ([203.197.150.194]:49297 "EHLO
	bhadra.amrita.ac.in") by vger.kernel.org with ESMTP id S261441AbVDTGaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 02:30:06 -0400
X-Antivirus-Amrita-Mail-From: harish@amritapuri.amrita.edu via bhadra.amrita.ac.in
X-Antivirus-Amrita: 1.24-st-qms (Clear:RC:1(127.0.0.1):. Processed in 0.03281 secs Process 23145)
Message-ID: <42225.203.197.150.195.1113980805.squirrel@mail.amrita.ac.in>
Date: Wed, 20 Apr 2005 12:36:45 +0530 (IST)
Subject: i830 lockup
From: "Harish K Harshan" <harish@amritapuri.amrita.edu>
To: linux-kernel@vger.kernel.org
Reply-To: harish@amritapuri.amrita.edu
User-Agent: SquirrelMail/1.4.4-1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I am developing a device driver for the AxiomTek AX5621H data
acquisition card, and I am encountering some problems on a particular
machine. This driver works pretty fine on normal machines, but crashes
on an Industrial PC with intel 830 2-piece board (with the main board
going into a PCI and an ISA slot on the expansion board(which houses
all the PCI, ISA and AGP slots) at the same time. The error I get is
given below :

CPU 0 : Machine Check Exception : 0000000000000004
Bank 0 : a200000084010400
Kernel panic : CPU context corrupt
In interrupt handler - not syncing

The DMA channel I use is DMA1, and i check for free interrupts and then
allocate them accordingly. So there is no conflicts, I assume. Also there
are no conflicts on the address range I have allocated (It is for now
0x300). The card supports only DMA channels 1 and 3. I have tried both, to
the same result. If anyone among you have had experience with such a
problem, any help in fixing this matter would be of great help.


Thank You.
Harish Harshan.


-----------------------------------------
This email was sent using Amrita Mail.
   "Amrita Vishwa Vidyapeetham [Deemed University] - Amritapuri Campus"
http://amritapuri.amrita.edu

