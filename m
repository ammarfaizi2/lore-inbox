Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286816AbSABJIZ>; Wed, 2 Jan 2002 04:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286780AbSABJIP>; Wed, 2 Jan 2002 04:08:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56328 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286815AbSABJIA>; Wed, 2 Jan 2002 04:08:00 -0500
Subject: Re: [RFC] Embedded X86 systems Was: [PATCH][RFC] AMD Elan patch
To: wingel@t1.ctrl-c.liu.se
Date: Wed, 2 Jan 2002 09:18:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, hpa@zytor.com, robert@schwebel.de,
        linux-kernel@vger.kernel.org, jason@mugwump.taiga.com,
        anders@alarsen.net, rkaiser@sysgo.de
In-Reply-To: <20020102090532.BB2B236F9F@hog.ctrl-c.liu.se> from "Christer Weinigel" at Jan 02, 2002 10:05:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LhXG-0003On-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think that only the Cx550 IDE stuff is in the main kernel though,
> the Cx5530 audio is a separate patch.  Also, the PCI IDs have change

The 5530 audio is emulated SB16 by the BIOS firmware. There is a hideous
native mode driver but it was too disgusting to even consider a merge and
needs bios stuff that pretty much no real world 5530 based device has.

> for the SCx200, so the IDE driver needs to be updated.  I have a patch
> for this and it seems to work, but I want to test it a bit more first.

Ok

