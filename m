Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbSLRXSN>; Wed, 18 Dec 2002 18:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267401AbSLRXSN>; Wed, 18 Dec 2002 18:18:13 -0500
Received: from mail7.home.nl ([213.51.128.24]:38389 "EHLO mail7-sh.home.nl")
	by vger.kernel.org with ESMTP id <S267399AbSLRXSL>;
	Wed, 18 Dec 2002 18:18:11 -0500
From: Frank van de Pol <fvdpol@home.nl>
Date: Thu, 19 Dec 2002 00:28:53 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.5.52: PDC20268 failure
Message-ID: <20021218232901.GA20290@idefix.fvdpol.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.18 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the 2.5 series of kernels (since early ide changes) fails on my machine when
configuring the harddisks.

machine is a dual P-II 300 MHz, Intel BX chipset
two Promise UltraTx2 boards, PDC20268, with an IBM disk connected to every channel.

kernel 2.4.18 is still running ok for me. When running a 2.5.x kernel on
this same box, the cards seem te be assigned different interrupts (weird,
since the cards remain in the same slots etc.)


2.4.18: (works fine)
ide2 at 0xa800-0xa807,0xac02 on irq 17
ide3 at 0xb000-0xb007,0xb402 on irq 17
ide4 at 0xbc00-0xbc07,0xc002 on irq 18
ide5 at 0xc400-0xc407,0xc802 on irq 18


2.5.52: (lost interrupts)
ide2 at 0xa800-0xa807,0xac02 on irq 16
ide3 at 0xb000-0xb007,0xb402 on irq 16
ide4 at 0xbc00-0xbc07,0xc002 on irq 16
ide5 at 0xc400-0xc407,0xc802 on irq 16


Regards,
Frank.

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?
