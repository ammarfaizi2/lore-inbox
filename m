Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSADTiL>; Fri, 4 Jan 2002 14:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288735AbSADTiC>; Fri, 4 Jan 2002 14:38:02 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:17653 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S288732AbSADTht>; Fri, 4 Jan 2002 14:37:49 -0500
Date: Fri, 4 Jan 2002 20:36:06 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020104200410.E21887@suse.cz>
Message-ID: <Pine.GSO.3.96.1020104202932.829H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Vojtech Pavlik wrote:

> And of course, there will be a huge amount of false positives, because
> all the new chipsets have an ISA bridge built into the southbridge chip
> and it is there even when no ISA slots are present.

 A false positive is less painful than a false negative.  Then if a system
has a PCI-ISA bridge, it's surely for purpose there (otherwise what is the
justification for the additional cost of unused silicon?).  Maybe for an
on-board ISA serial or parallel port or an ISA floppy controller...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

