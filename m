Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288716AbSADSgt>; Fri, 4 Jan 2002 13:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288719AbSADSgH>; Fri, 4 Jan 2002 13:36:07 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:36596 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S288716AbSADSgB>; Fri, 4 Jan 2002 13:36:01 -0500
Date: Fri, 4 Jan 2002 19:28:58 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020103133454.A17280@suse.cz>
Message-ID: <Pine.GSO.3.96.1020104191141.829B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Vojtech Pavlik wrote:

> > Thats why I also suggested using lspci and looking for an ISA bridge.
> > If you have no PCI its probably ISA. If you have no PCI/ISA bridge its
> > very very unlikely to be ISA
> 
> Uh, no. Almost all 486 PCI boards and early Pentium/K5/K6 boards have
> the PCI bus hanging of the VLB or other local bus, and on those ISA
> isn't behind an ISA bridge. These chipsets do have ISA but no ISA
> bridge.

 These can be checked for explicitly as the list isn't likely to grow.  I
can dig a few Intel docs for IDs of 486-class PCI chipsets that have no
PCI-ISA bridge if they'd be useful.

 Also note that there are PCI-ISA bridges that are reported as "non-VGA
unclassified" devices as they predate PCI 2.0.  The SIO (82378IB/ZB) comes
to mind here.  The bridge is used in certain models of Alpha systems as
well.  The bridges would need to be listed by IDs, too. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

