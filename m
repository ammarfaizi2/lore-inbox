Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQK3D0x>; Wed, 29 Nov 2000 22:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129226AbQK3D0n>; Wed, 29 Nov 2000 22:26:43 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:24636 "EHLO
        amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
        id <S129183AbQK3D0e>; Wed, 29 Nov 2000 22:26:34 -0500
Date: Thu, 30 Nov 2000 05:03:38 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: USB doesn't work with 440MX chipset, PCI IRQ problem?
In-Reply-To: <20001130004123.B1327@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.21.0011300501500.8081-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>              CPU0       
>     0:    1415829          XT-PIC  timer
>     1:      10361          XT-PIC  keyboard
>     2:          0          XT-PIC  cascade
>     3:      70687          XT-PIC  serial
>     5:          0          XT-PIC  Intel ICH
>     9:       3134          XT-PIC  3c574_cs
>    11:          1          XT-PIC  Ricoh Co Ltd RL5c475, usb-uhci

Your videocard is also at 11. Could be an issue if the USB driver hates
sharing IRQ's.

>    12:      18847          XT-PIC  PS/2 Mouse
>    14:     146954          XT-PIC  ide0
>   NMI:          0 
>   ERR:          0


<snip tons of info>

Nothing in there that I would lie awake from.

> Erik


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
