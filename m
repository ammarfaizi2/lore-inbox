Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbQLUM0E>; Thu, 21 Dec 2000 07:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130193AbQLUMZx>; Thu, 21 Dec 2000 07:25:53 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:63411 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129718AbQLUMZm>; Thu, 21 Dec 2000 07:25:42 -0500
Date: Thu, 21 Dec 2000 12:54:10 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@chiara.elte.hu
Subject: Re: Startup IPI (was: Re: test13-pre3)
In-Reply-To: <103B2E14508A@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1001221123639.9979B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Petr Vandrovec wrote:

> /usr/bin/time says that program runs for 3.40 - 3.56secs, so after dividing

 Well, the test looks reasonable if the system load is low.  Still the
performance is surprisingly low -- after changing the transfer width to 16
bits I ran the test on my dual P5MMX system equipped with an old ISA VGA
card and I achieved 10.74ms for VGA RAM accesses and 586.6us for uncached
main memory accesses. 

> by 1000 I get 3.4ms... Maybe I should complain to VIA or to Matrox that
> it is piece of crap ?

 For VIA -- definitely.  I don't think Matrox is at fault, though. 

> My order was simple: no rambus memory, dual PIII at least on 800MHz
> and UDMA66. Yes, maybe I should buy ServerWorks instead of VIA, but 
> I hoped...

 At least ServerWorks claims they are willing to cooperate with us
although results seem to be questionable so far... 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
