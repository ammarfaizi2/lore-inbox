Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSFBNZa>; Sun, 2 Jun 2002 09:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317177AbSFBNZ3>; Sun, 2 Jun 2002 09:25:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24569 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317176AbSFBNZ3>; Sun, 2 Jun 2002 09:25:29 -0400
Subject: Re: FUD or FACTS ?? but a new FLAME!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0206021405070.1886-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Jun 2002 15:29:44 +0100
Message-Id: <1023028184.23878.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-02 at 13:11, Bartlomiej Zolnierkiewicz wrote:
> So what should we do in case of overclocked PCI bus?
> Get overclocked ATA or try to mess with timings?

You cannot overclock the AMD on chipset IDE or the intel on chipset IDE.
It doesn't actually matter what you do the system is going to be way out
of wack. These are chipset bridges rather than card people ram into
weird bits of hardware.

The VIA stuff and the Promise it makes some sense to try because they
may be shoved in boxes with a 25MHz PCI clock, or in a few cases a
horribly broke 37.5/41Mhz bus from the early chipsets that had 'idiot
only' 75/83Mhz FSB options

