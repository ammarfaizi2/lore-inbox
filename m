Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290770AbSAYSmd>; Fri, 25 Jan 2002 13:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290776AbSAYSmN>; Fri, 25 Jan 2002 13:42:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9740 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290770AbSAYSmL>; Fri, 25 Jan 2002 13:42:11 -0500
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 25 Jan 2002 18:54:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        Martin.Wilck@fujitsu-siemens.com (Martin Wilck),
        linux-kernel@vger.kernel.org (Linux Kernel mailing list),
        rgooch@atnf.csiro.au (Richard Gooch),
        marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <Pine.LNX.4.33.0201251009300.1632-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 25, 2002 10:14:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UBUl-0003J9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Dave pointed out I was mixing them

> just not do it on the right CPU (you're _not_ supposed to read to see if
> you are writing the same value: MTRR's can at least in theory have
> side-effects, so it's not the same check as for the microcode update).

So why not just set it twice - surely that is harmless ? Why add complex
code ?
