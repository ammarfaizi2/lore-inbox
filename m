Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKPOnT>; Thu, 16 Nov 2000 09:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbQKPOnK>; Thu, 16 Nov 2000 09:43:10 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:49121 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129132AbQKPOm6>; Thu, 16 Nov 2000 09:42:58 -0500
Date: Thu, 16 Nov 2000 15:08:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: New bluesmoke patch available, implements MCE-without-MCA support
In-Reply-To: <8uuvnk$1v8$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.3.96.1001116145330.15690B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would appreciate it if people who have chips with MCE but no MCA --
> this includes older AMD chips and some Cyrix chips at the very least
> -- would please be so kind and try this out.

 Hmm, I've looked at the patch and I guess you may try to decode MSR#0 and
MSR#1 for Pentium processors (I may provide an example patch).  I believe
certain AMD processors support these registers, too.  I don't know how
other vendors treat MSR#0 and MSR#1 but given they were sufficiently
documented since the beginning, they may very well be pretty standard for
all of them.

 I'll try the patch at my Pentium machine, yet, but it runs so stable I
don't expect an MCE anytime soon. ;-}

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
