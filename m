Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271965AbRIDNAS>; Tue, 4 Sep 2001 09:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271966AbRIDNAI>; Tue, 4 Sep 2001 09:00:08 -0400
Received: from a407.woctni.sk ([195.28.70.181]:31251 "EHLO a407.woctn.sk")
	by vger.kernel.org with ESMTP id <S271965AbRIDM74>;
	Tue, 4 Sep 2001 08:59:56 -0400
Message-ID: <XFMail.010904145710.rastos@woctni.sk>
X-Mailer: XFMail 1.3 [p0] on HP-UX (unknown)
X-Priority: 3 (Normal)
X-Chameleon-Return-To: rastos@woctni.sk
X-XFmail-Return-To: rastos@woctni.sk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Tue, 04 Sep 2001 14:57:10 +0200 (METDST)
Reply-To: Rastislav Stanik <rastos@woctni.sk>
Organization: West Ost Connection s.r.o.
From: Rastislav Stanik <rastos@woctni.sk>
To: linux-kernel@vger.kernel.org
Subject: Should I use Linux to develop driver for specialized ISA card?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to know your opinion on following problem:

I'm developing specialized plotter.
The moving parts of the plotter are controlled by ISA card that generates
(and responds to) interrupts on each movement or printing event.
The interrupts can be generated quite fast; up to frequency of 4kHz.

I need to write a driver for that.
The 1st prototype is developed in MS-DOS,but I hit problem with memory.
The driver needs to use (and transfer) quite big chunks of memory.
1MB is not enough.

In NT you don't develop drivers so easily. It is actually a pain.
Therefore I'm considering Linux. The machine would be probably 
dedicated and, may be later, embeded in the plotter.
Problems:
- It is unlikely that my driver would ever make it to main-stream kernel source.
- I'm just a C/C++ programmer, I have just rough idea what does it mean to
'develop a driver in Linux'. I'm pretty familiar with Linux as sys-admin though.

All I need is: to have piece of code executed on some interrupt,
read/write IO ports of the card and be able to transfer big pieces
of memory to the card.

What do you think? Is Linux the ideal platform for me?

Please, Cc: to rastos@woctni.sk, I'm not subscribed to the mailing list (yet).
---
        bye
                rastos
