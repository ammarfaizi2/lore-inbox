Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262930AbREWAiC>; Tue, 22 May 2001 20:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbREWAhw>; Tue, 22 May 2001 20:37:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23302 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262932AbREWAhc>; Tue, 22 May 2001 20:37:32 -0400
Subject: Re: 2.4.4 -  I2O printer port weirdness
To: jd@dyatron.co.nz (John at Dyatron)
Date: Wed, 23 May 2001 01:34:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <005901c0e31f$fa89cc80$2bfefe0a@dyatron.co.nz> from "John at Dyatron" at May 23, 2001 12:33:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152Mc2-0002kI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I2C Printer port detects , then
> 0x378 detects too
> but both are parport0 ?
> 
> SMSC Super-IO detection, now testing Ports 2F0, 370 ...
> parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]

Thata your parallel port

> i2c-philips-par.o: i2c Philips parallel port adapter module
> i2c-philips-par.o: attaching to parport0
> i2c-dev.o: Registered 'Philips Parallel port adapter' as minor 0

Then for some reason you attached a driver for external i2c bus onto it.

I suspect you compiled things into your kernel you didnt mean too 8)

