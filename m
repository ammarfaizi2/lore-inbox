Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310164AbSCKPgY>; Mon, 11 Mar 2002 10:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310166AbSCKPgO>; Mon, 11 Mar 2002 10:36:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28170 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310164AbSCKPgA>; Mon, 11 Mar 2002 10:36:00 -0500
Subject: Re: Busmaster DMA broken in 2.4.18 on Alpha
To: Jay.Estabrook@compaq.com (Jay Estabrook)
Date: Mon, 11 Mar 2002 15:45:42 +0000 (GMT)
Cc: ink@jurassic.park.msu.ru (Ivan Kokshaysky), garloff@suse.de (Kurt Garloff),
        jochen@scram.de (Jochen Friedrich), linux-kernel@vger.kernel.org,
        rth@twiddle.net (Richard Henderson)
In-Reply-To: <20020311100200.A1181@linux04.mro.cpqcorp.net> from "Jay Estabrook" at Mar 11, 2002 10:02:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kRza-0000t8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are ISA cards, regardless of what ISA bus machine they are
> plugged into, that are able to generate only something less than
> 32-bits worth of address. I believe that the Adaptec 1540 SCSI

All busmasters in fact. There are only 24 address wires on the ISA bus. That
covers stuff from tpqic02 through pcnet/isa, lance and aha154x.

Alan
