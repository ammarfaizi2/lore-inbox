Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311721AbSC2Tpm>; Fri, 29 Mar 2002 14:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSC2Tpd>; Fri, 29 Mar 2002 14:45:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1549 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311721AbSC2TpO>; Fri, 29 Mar 2002 14:45:14 -0500
Subject: Re: 2.4.19-pre4-ac[23] do not boot
To: andre@linux-ide.org (Andre Hedrick)
Date: Fri, 29 Mar 2002 20:01:30 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jean-luc.coulon@wanadoo.fr (Jean-Luc Coulon),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10203291137220.10681-100000@master.linux-ide.org> from "Andre Hedrick" at Mar 29, 2002 11:42:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16r2Z0-0001tR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is possible, however one of the problems encountered is the
> following under several chipsets.  If there is no pio timing set at all,
> then we can run into host lock issues if the driver drops out of dma.
> Thus, if it is going to lockup here it would/could lock up in other
> places when one trys to program the host for PIO.

Well right at the moment the ALi locks up on boot reliably. That means a
fix has to be found, or the ALi changes reverted 
