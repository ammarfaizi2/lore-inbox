Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbQLQQx3>; Sun, 17 Dec 2000 11:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130076AbQLQQxU>; Sun, 17 Dec 2000 11:53:20 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:55208 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130069AbQLQQxR>; Sun, 17 Dec 2000 11:53:17 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200012171622.RAA20222@sunrise.pg.gda.pl>
Subject: Re: [patch] 2.4.0-test13-pre2: mark CONFIG_PARPORT_PC_FIFO experimental
To: twaugh@redhat.com (Tim Waugh)
Date: Sun, 17 Dec 2000 17:22:23 +0100 (MET)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20001217122404.C19671@redhat.com> from "Tim Waugh" at Dec 17, 2000 12:24:04 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tim Waugh wrote:"
> Hi Linus,
> 
> Here is a patch that marks CONFIG_PARPORT_PC_FIFO experimental.

Why it does not depend on CONFIG_EXPERIMENTAL if it really is experimental ?
 
> --- linux-2.4.0-test13-pre1/drivers/parport/Config.in.fifoexp	Thu Jun 29 10:20:36 2000
> +++ linux-2.4.0-test13-pre1/drivers/parport/Config.in	Thu Dec 14 11:38:53 2000
> @@ -12,7 +12,7 @@
>  if [ "$CONFIG_PARPORT" != "n" ]; then
>     dep_tristate '  PC-style hardware' CONFIG_PARPORT_PC $CONFIG_PARPORT
>     if [ "$CONFIG_PARPORT_PC" != "n" ]; then
> -      bool '    Use FIFO/DMA if available' CONFIG_PARPORT_PC_FIFO
> +      bool '    Use FIFO/DMA if available (EXPERIMENTAL)' CONFIG_PARPORT_PC_FIFO
>        if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
>           bool '    SuperIO chipset support (EXPERIMENTAL)' CONFIG_PARPORT_PC_SUPERIO
>        fi
--
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
