Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132240AbQKZTNv>; Sun, 26 Nov 2000 14:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132580AbQKZTNl>; Sun, 26 Nov 2000 14:13:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46932 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S132240AbQKZTN3>; Sun, 26 Nov 2000 14:13:29 -0500
Subject: Re: 2.4.0-test11: Trying to free nonexistent resource <000003e0-000003e1>
To: dwmw2@infradead.org (David Woodhouse)
Date: Sun, 26 Nov 2000 18:42:27 +0000 (GMT)
Cc: F.vanMaarseveen@inter.NL.net (Frank van Maarseveen),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0011261830210.13161-100000@imladris.demon.co.uk> from "David Woodhouse" at Nov 26, 2000 06:33:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1406kv-0002Eq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Nov 25 23:15:14 mimas kernel: Trying to free nonexistent resource <000003e0-000003e1>
> > Nov 25 23:15:14 mimas kernel: unloading PCMCIA Card Services
> 
> This is normal behaviour. It's buggy but it's harmless. It'll go away when
> the i82365 driver is rewritten in 2.5.

Why not fix it for 2.4. It doesnt actually seem hard ?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
