Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264546AbRFPODe>; Sat, 16 Jun 2001 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbRFPODY>; Sat, 16 Jun 2001 10:03:24 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:53172 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S264546AbRFPODS>; Sat, 16 Jun 2001 10:03:18 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200106161356.OAA08201@mauve.demon.co.uk>
Subject: Re: Changing CPU Speed while running Linux
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 16 Jun 2001 14:56:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15BG33-00083s-00@the-village.bc.nu> from "Alan Cox" at Jun 16, 2001 02:23:33 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Can you dig that out? I'd like to take a look.
> > 
> > [Of course, problem is *not* solved: you still have short time when
> > kernel runs with wrong bogomips.]
> 
> Not really. WHen you do the speed change on most of these cpus you have to
> do it with IRQs off and with the PCI bridge temporarily disabled as the CPU
> disconnects from the bus during speed transititions and cannot take part in
> cache coherency

Though it's been a while, last time I read the elan sc400 (or was it the 
410, always get those two mixed up), datasheet, there were no 
special procedures needed, just change the speed.
This may have been because there is no external PCI bus.
