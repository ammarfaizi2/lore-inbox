Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132403AbQL1M7I>; Thu, 28 Dec 2000 07:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132424AbQL1M66>; Thu, 28 Dec 2000 07:58:58 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:47344 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132403AbQL1M6r>; Thu, 28 Dec 2000 07:58:47 -0500
Date: Thu, 28 Dec 2000 13:25:56 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Joe deBlaquiere <jadb@redhat.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>,
        the list <linux-kernel@vger.kernel.org>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: sysmips call and glibc atomic set
In-Reply-To: <3A48CC1D.9000204@redhat.com>
Message-ID: <Pine.GSO.3.96.1001228132356.21148C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Dec 2000, Joe deBlaquiere wrote:

> > Read the ISA manual; sc will fail if the LL-bit in c0_status is cleared
> > which will be cleared when the interrupt returns using the eret instruction.
> 
> I tried to find a MIPSIII manual from mips.com but all I could find was 
> mips32 and mips64 (which are not the same as MIPSII/MIPSIII/MIPSIV).

 Get "IDT MIPS Microprocessor Software Reference Manual" from
http://decstation.unix-ag.org/docs/ic_docs/3715.pdf (the original is no
longer available from IDT servers).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
