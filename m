Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312300AbSCTXuv>; Wed, 20 Mar 2002 18:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312301AbSCTXun>; Wed, 20 Mar 2002 18:50:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46353 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312299AbSCTXuc>; Wed, 20 Mar 2002 18:50:32 -0500
Subject: Re: Linux 2.4.19-pre4: pdcadma.c still missing ?
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Thu, 21 Mar 2002 00:06:32 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3C99168A.F30EB8D6@eyal.emu.id.au> from "Eyal Lebedinsky" at Mar 21, 2002 10:08:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nq6C-0003m2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So here goes pre4, now with a much more detailed changelog...
> 
> Or maybe the makefile should not include it?
> 
> ld: cannot open pdcadma.o: No such file or directory
> make[3]: *** [ide-mod.o] Error 1
> make[3]: Leaving directory

It should be comemnted out in the Config.in file for that directory. I
sent that diff, must have escaped the merge. Grab it from -ac
