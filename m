Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131717AbRAaRg3>; Wed, 31 Jan 2001 12:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130941AbRAaRgU>; Wed, 31 Jan 2001 12:36:20 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:8880 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130312AbRAaRgE>; Wed, 31 Jan 2001 12:36:04 -0500
Date: Wed, 31 Jan 2001 18:19:53 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
In-Reply-To: <E14O0hv-0002hY-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1010131181206.16241A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Alan Cox wrote:

> > Does Linus or anyone object to raising the ksmg buffer from 16K to 32K?
> > 4/5 systems I have now overflow the buffer during boot before init is
> > even launched.
> 
> Thats just an indication that 2.4.x is currently printking too much crap on
> boot

 We could probably get rid of much of the crap for i386 by #undef
APIC_DEBUG in include/asm-i386/apic.h.  Too bad broken SMP systems get
reported every now and then and the crap proves useful in getting what
actually is wrong. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
