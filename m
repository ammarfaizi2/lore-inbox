Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133093AbRDLKLQ>; Thu, 12 Apr 2001 06:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133094AbRDLKK4>; Thu, 12 Apr 2001 06:10:56 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:21639 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S133093AbRDLKKq>; Thu, 12 Apr 2001 06:10:46 -0400
Date: Thu, 12 Apr 2001 11:51:07 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Zdenek Kabelac <kabi@i.am>, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <20010411181310.C23974@pcep-jamie.cern.ch>
Message-ID: <Pine.GSO.3.96.1010412113214.17378A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001, Jamie Lokier wrote:

> Think of the original 64k and 256k VGA cards.  I think some of those
> didn't have an irq, but did have a way to read the progress of the
> raster, which you could PLL to using timer interrupts.  Some video games
> still look fine at 320x200 :-)

 The *original* VGA, i.e. the PS/2 one, did have an IRQ, IIRC (according
to docs -- I haven't ever seen one).  Cheap clones might have lacked it,
though.

 Then there is workstation (non-PC)  hardware from early '90s which we run
on and which uses an IRQ-driven interface to graphics adapters -- not only
for vsync. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

