Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271694AbRH0Knh>; Mon, 27 Aug 2001 06:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271696AbRH0Kn1>; Mon, 27 Aug 2001 06:43:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3333 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271694AbRH0KnS>; Mon, 27 Aug 2001 06:43:18 -0400
Subject: Re: Slow system with K7
To: ccosta@servidores.net (Carlos Costa Portela)
Date: Mon, 27 Aug 2001 11:46:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108271226250.1437-100000@merry.comarca.tm> from "Carlos Costa Portela" at Aug 27, 2001 12:30:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bJuQ-0003ge-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	1. the system is more loaded than in the pentium epoch
> 	2. sometimes, the system "stops" for small periods of time (< 1s).
> 	I am using 2.4.9 kernel. Can you give me any tip to get the most
         ^^^^^^^^^^^^^^^^^^^

I suspect that bit is your actual problem. 

> from my system?. I'm recompiling all applications and, yes, if once
> recompiled I can see that the system improves.

>From what I can measure Athlon specific code really only makes a difference
when using prefetches, mmx or 3dnow. For most code streams Athlon's seem
to extract good parallelism out of 586/686/k6/.. code.

Alan
