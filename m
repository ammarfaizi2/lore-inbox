Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284755AbSADU0M>; Fri, 4 Jan 2002 15:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284842AbSADU0C>; Fri, 4 Jan 2002 15:26:02 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:57077 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S284755AbSADUZs>; Fri, 4 Jan 2002 15:25:48 -0500
Date: Fri, 4 Jan 2002 21:24:40 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Jones <davej@suse.de>
cc: "Eric S. Raymond" <esr@thyrsus.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.33.0201042054080.20620-100000@Appserv.suse.de>
Message-ID: <Pine.GSO.3.96.1020104211143.829K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Dave Jones wrote:

> At the beginning of this thread I believe it was discussed splitting
> the config option into CONFIG_ISA and CONFIG_ISASLOTS

 That seems impossible in the real world.  I don't think it's possible to
detect physical connectors on a PCB for any bus -- I've even seen boards
with soldering spots for bus connectors but no connectors themselves. 
Relying on reporting anything optional being done right by a BIOS is an
illusion -- even mandatory things are screwed in many PC BIOSes.  For the
said boards firmware is likely identical as for ones with real connectors. 

 Also the choice of devices to depend on CONFIG_ISASLOTS is tough?  How do
you know which ones exist in an on-board configuration somewhere and which
ones do not?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

