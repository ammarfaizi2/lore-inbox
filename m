Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288751AbSADUKm>; Fri, 4 Jan 2002 15:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284728AbSADUK1>; Fri, 4 Jan 2002 15:10:27 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:42741 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S288744AbSADUKC>; Fri, 4 Jan 2002 15:10:02 -0500
Date: Fri, 4 Jan 2002 21:08:59 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020104204508.C22591@suse.cz>
Message-ID: <Pine.GSO.3.96.1020104205359.829J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Vojtech Pavlik wrote:

> Because it's much cheaper to buy an off-the-shelf southbridge, even if
> you're not going to use the ISA bus for any devices if you're making an
> ISA-less mainboard, than trying to find or even design one without an
> ISA bridge in it.

 Hmm, what exactly do you need a southbridge for in an ISA-less system? 
For IDE or USB you may use chips with no PCI-ISA bridge.  They are likely
to be cheaper, take less space on a PCB and consume less power. 

> I recall people using the vt82c686a's with StrongARM CPUs even ...

 Can't say anything about StrongARM boards, but it's possible they wire a
serial port this way (not a rare device in the embedded world). 

 OK, it is possible there are systems that have all the logic for an ISA
bus but it's left unused.  But given the insanity of the PC world, it's
still better to ask user a few unneeded questions than to refuse to ask
necessary ones.  This also gives a user the chance to ask the vendor: "Why
does your supposedly legacy-free system still contain an ISA device?" ;-) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

