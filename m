Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKVNAu>; Wed, 22 Nov 2000 08:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQKVNAl>; Wed, 22 Nov 2000 08:00:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4449 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129259AbQKVNAa>; Wed, 22 Nov 2000 08:00:30 -0500
Subject: Re: Why not PCMCIA built-in and yenta/i82365 as modules
To: matti.aarnio@zmailer.org (Matti Aarnio)
Date: Wed, 22 Nov 2000 12:29:42 +0000 (GMT)
Cc: tori@tellus.mine.nu (Tobias Ringstrom), dhinds@zen.stanford.edu,
        torvalds@transmeta.com,
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20001122122543.A28963@mea-ext.zmailer.org> from "Matti Aarnio" at Nov 22, 2000 12:25:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yZ1z-0005uY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wasn't there some strange laptop model which had PCMCIA floppy/CDROM,
> which are unavailable to bootstrap process, unless PCMCIA is supported
> at the booting kernel ?

I have seen a couple where the floppy/cdrom are supported by the bios but
then vanish. Generally they are left mapped which means if you know the
right ide= incantation it works.

Remember you can solve this with an initrd. 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
