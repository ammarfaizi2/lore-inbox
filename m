Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSA1Uzq>; Mon, 28 Jan 2002 15:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSA1Uzg>; Mon, 28 Jan 2002 15:55:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43530 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284305AbSA1Uzb>; Mon, 28 Jan 2002 15:55:31 -0500
Subject: Re: Athlon Optimization Problem
To: calin@ajvar.org (Calin A. Culianu)
Date: Mon, 28 Jan 2002 21:08:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        hassani@its.caltech.edu (Steven Hassani), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0201281551250.2376-100000@rtlab.med.cornell.edu> from "Calin A. Culianu" at Jan 28, 2002 03:53:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VJ0e-0001me-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm.  What do you recommend?  I remember seeing a spec sheet and register
> 0x95 was the memory write queue timer.. but I could have dreamed it..
> Anyone know what register 0x95 does?

It may well the case. All I know is that for some people at least leaving
0x95 as the bios set it up works and touching it does not - while for
the 0x55 case on older chips it all seems to be positive. VIA's own stuff
doesn't touch 0x95 - maybe there is a reason
