Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLaDLw>; Sat, 30 Dec 2000 22:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135773AbQLaDLm>; Sat, 30 Dec 2000 22:11:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49675 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135755AbQLaDLd>; Sat, 30 Dec 2000 22:11:33 -0500
Subject: Re: test13-pre4-ac2/test13-pre7 ax25 undefined reference
To: sidb@FreeNet.co.uk
Date: Sun, 31 Dec 2000 02:43:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A4E9B70.574B1A51@FreeNet.co.uk> from "Sid Boyce" at Dec 31, 2000 02:35:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14CYSv-0007Qr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	The problem showed up on the stroke of test13-pre4-ac2 and stuff from
> Alan has been merged in. I went from pre4-ac2 to pre5 (AOK) and now
> attempting pre7.......

Its definitely coming from the AX.25 related changes. Please send me your
.config and I'll go squash this one

> drivers/net/net.o: In function `network_ldisc_init':
> drivers/net/net.o(.text.init+0x141): undefined reference to
> `mkiss_init_ctrl_dev
> '
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
