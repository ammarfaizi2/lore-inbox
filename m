Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130875AbQKUTFK>; Tue, 21 Nov 2000 14:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130989AbQKUTFE>; Tue, 21 Nov 2000 14:05:04 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:55701 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130875AbQKUTEw>; Tue, 21 Nov 2000 14:04:52 -0500
Date: Tue, 21 Nov 2000 19:25:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
In-Reply-To: <E13yI03-0004yv-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1001121192317.28403B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Alan Cox wrote:

> > > o	Dont crash on boot with a dual cpu board holding a non intel cpu
> > 
> > Is this the patch to check for the Local APIC?
> 
> Yep

 Hmm, that's weird -- the check is already there for some time -- see
verify_local_APIC().  It works and it's reliable even for the 82489DX.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
