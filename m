Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQJ2UdV>; Sun, 29 Oct 2000 15:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129331AbQJ2UdM>; Sun, 29 Oct 2000 15:33:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9008 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129253AbQJ2Uc4>; Sun, 29 Oct 2000 15:32:56 -0500
Subject: Re: [patch] NE2000
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 29 Oct 2000 20:34:06 +0000 (GMT)
Cc: pavel@web.sajt.cz (pavel rabel), linux-net@vger.kernel.org,
        p_gortmaker@yahoo.com, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <39FC83CD.B10BF08D@mandrakesoft.com> from "Jeff Garzik" at Oct 29, 2000 03:08:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pz9c-0006Jh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This change sounds ok to me, if noone else objects.  (I added to the CC
> a bit)  I saw that code, and was thinking about doing the same thing
> myself.  ne2k-pci.c definitely has changes which are not included in
> ne.c, and it seems silly to duplicate ne2000 PCI support.

Unless there are any cards that need the bug workarounds in ne.c for use
on PCI then I see no problem. I've not heard of any. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
