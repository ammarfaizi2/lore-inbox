Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbTABWcu>; Thu, 2 Jan 2003 17:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267293AbTABWcu>; Thu, 2 Jan 2003 17:32:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49801
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267291AbTABWcs>; Thu, 2 Jan 2003 17:32:48 -0500
Subject: Re: UDMA 133 on a 40 pin cable
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Teodor Iacob <Teodor.Iacob@astral.kappa.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E14B698.8030107@inet6.fr>
References: <20030102182932.GA27340@linux.kappa.ro>
	<1041536269.24901.47.camel@irongate.swansea.linux.org.uk> 
	<3E14B698.8030107@inet6.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Jan 2003 23:24:07 +0000
Message-Id: <1041549847.24901.71.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 22:00, Lionel Bouton wrote:
> I'm wondering some things about IDE 40/80 pin cables since some time ago :
> - somehow the circuitry can make the difference between 40 and 80 pin 
> (probably some pins are shorted or not by the cables or some 
> cable-type-dependent impedance between wires is mesured) and set a bit 
> for us to use.
> - most probably the same circuitry can't verify the length of the cables 
> or their overall quality but I'm unsure.
> 
> #1 How is the 40/80 pin detection done at the hardware level ?
> #2 Are there any other cable-quality hardware tests done by the chipsets 
> ? How ?

Oh god. Andre described this one as needing a "two beer" explanation.
I'd recommend stronger drinks however.

> I've encountered a barebone design (Mocha P4, uses 2.5" drives) where 
> the IDE cable was 40-pin but :
> - has a single drive connector instead of the common two,
> - its length is only around 10 or 15 cm.
> A buyer contacted me for SiS IDE driver directions on this platform and 
> confirmed this at least for his purchase.
> 
> #3 Is the above cable electrically able to sustain 66+ UDMA transfers 
> (could I hack a driver in order to bypass the 80pin cable detection and 
> make it work properly) ?

It is possible to do this yes. Other vendors do it as well. Careful
cable choice lets you meet the electrical requirements other ways in
certain situations.



