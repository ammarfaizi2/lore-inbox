Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129426AbQK2Amx>; Tue, 28 Nov 2000 19:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129555AbQK2Amd>; Tue, 28 Nov 2000 19:42:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28992 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129426AbQK2Ama>; Tue, 28 Nov 2000 19:42:30 -0500
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
To: odd@findus.dhs.org (Petter Sundlöf)
Date: Wed, 29 Nov 2000 00:12:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A244792.5FABBE38@findus.dhs.org> from "Petter Sundlöf" at Nov 29, 2000 01:02:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140urK-0005FZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks to some nice people in #NVIDIA I found what seems to be a
> solution; compile with processor type as "K6". No segfaults, lost
> terminfo or disabled consoles.
> 
> So are there issues with the K7 processor code? Bleh, never mind, I have
> no idea what I am talking about.

The K7 optimisations are not used for I/O space accessess. Or shouldnt be,
but the nvidia code is unreadable so they may have done so

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
