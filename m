Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288154AbSAMVA5>; Sun, 13 Jan 2002 16:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288153AbSAMVAr>; Sun, 13 Jan 2002 16:00:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54538 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288149AbSAMVAe>; Sun, 13 Jan 2002 16:00:34 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: zippel@linux-m68k.org (Roman Zippel)
Date: Sun, 13 Jan 2002 21:11:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rml@tech9.net (Robert Love),
        ken@canit.se (Kenneth Johansson), arjan@fenrus.demon.nl,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <3C41ED4E.4D3F2D2C@linux-m68k.org> from "Roman Zippel" at Jan 13, 2002 09:25:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Prv5-00080m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't doubt that, but would you seriously consider the ll patch for
> inclusion into the main kernel?

The mini ll patch definitely. The full ll one needs some head scratching to
be sure its correct. pre-empt is a 2.5 thing which in some ways is easier
because it doesnt matter if it breaks something.

> Please let me rephrase, I just don't expect terrible good latency
> numbers with non dma hardware.

Expect the same with DMA hardware too at times.
