Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284842AbSADUcc>; Fri, 4 Jan 2002 15:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288755AbSADUcS>; Fri, 4 Jan 2002 15:32:18 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:63221 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S288747AbSADUb5>; Fri, 4 Jan 2002 15:31:57 -0500
Date: Fri, 4 Jan 2002 21:30:47 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Weinehall <tao@acc.umu.se>
cc: "Eric S. Raymond" <esr@thyrsus.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020104211931.D5235@khan.acc.umu.se>
Message-ID: <Pine.GSO.3.96.1020104212646.829L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, David Weinehall wrote:

> If you find an MCA-bus, you can suppress most (but not all) ISA-cards
> too (some of the cards support MCA without having any extra MCA-related
> code in the drivers, such as the eexpress-driver, but I can help with
> such a list if necessary.)

 Shouldn't the drivers depend on "CONFIG_ISA or CONFIG_MCA" then?  Just
like CONFIG_DEFXX depends on "CONFIG_PCI or CONFIG_EISA"? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

