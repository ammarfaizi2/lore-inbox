Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRBIMPT>; Fri, 9 Feb 2001 07:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130786AbRBIMPJ>; Fri, 9 Feb 2001 07:15:09 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:51113 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130485AbRBIMOx>; Fri, 9 Feb 2001 07:14:53 -0500
Date: Fri, 9 Feb 2001 13:10:33 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] Re: UP APIC reenabling vs. cpu type detection o
In-Reply-To: <14EFD2E43005@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1010209130727.4645E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Petr Vandrovec wrote:

> Unfortunately both these ways needs intimate knowledge of how UP NMI
> watchdog works in each kernel, and it is incompatible with other
> perfctr uses. Probably I'll switch perfctr delivery to some real
> maskable interrupt while VMware VM owns CPU - if it is possible.
> Then interrupt should be still pending after VM does __sti().

 Why do you need to mask NMI at all? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
