Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282473AbRKZUVb>; Mon, 26 Nov 2001 15:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282472AbRKZUVX>; Mon, 26 Nov 2001 15:21:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3846 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282479AbRKZUUy>; Mon, 26 Nov 2001 15:20:54 -0500
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
To: vda@port.imtp.ilyichevsk.odessa.ua (vda)
Date: Mon, 26 Nov 2001 20:28:03 +0000 (GMT)
Cc: mathijs@knoware.nl (Mathijs Mohlmann), bulb@ucw.cz (Jan Hudec),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <01112117122701.02798@nemo> from "vda" at Nov 21, 2001 05:12:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168SMG-0006k2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > MODINC(x,y) (x = (x % y) + 1)
> 
> drivers/message/i2o/i2o_config.c:#define MODINC(x,y) (x = x++ % y)
> 
> Alan, can you clarify what this macro is doing?
> What about making it less confusing?

Nothing to do with me 8). I didnt write that bit of the i2o code. I agree
its both confusing and buggy. Send a fix ?
