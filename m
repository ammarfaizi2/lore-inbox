Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288737AbSADTzC>; Fri, 4 Jan 2002 14:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288735AbSADTyz>; Fri, 4 Jan 2002 14:54:55 -0500
Received: from ns.suse.de ([213.95.15.193]:8718 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288741AbSADTym>;
	Fri, 4 Jan 2002 14:54:42 -0500
Date: Fri, 4 Jan 2002 20:54:41 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.GSO.3.96.1020104203829.829I-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0201042054080.20620-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Maciej W. Rozycki wrote:

>  What about CONFIG_BLK_DEV_FD, CONFIG_SERIAL and CONFIG_PARPORT_PC?  ISA
> devices of this kind are still often present in systems even if no ISA
> slots exist.  Actually CONFIG_BLK_DEV_FD is purely ISA and it uses ISA DMA
> (so it requires kernel/dma.c, which is ISA-only).

At the beginning of this thread I believe it was discussed splitting
the config option into CONFIG_ISA and CONFIG_ISASLOTS

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

