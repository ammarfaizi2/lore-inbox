Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131103AbRAQL3c>; Wed, 17 Jan 2001 06:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133112AbRAQL3N>; Wed, 17 Jan 2001 06:29:13 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:57313 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131103AbRAQL25>; Wed, 17 Jan 2001 06:28:57 -0500
Date: Wed, 17 Jan 2001 12:25:39 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Martin Mares <mj@suse.cz>
cc: Adam Lackorzynski <al10@inf.tu-dresden.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset
In-Reply-To: <20010117095221.A553@albireo.ucw.cz>
Message-ID: <Pine.GSO.3.96.1010117122300.22695B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Martin Mares wrote:

> I don't have the ServerWorks chipset documentation at hand, but I think your
> patch is wrong -- it doesn't make any sense to scan a bus _range_. The registers
> 0x44 and 0x45 are probably ID's of two primary buses and the code should scan
> both of them, but not the space between them.

 Does anyone beside the manufacturer have these docs at all?  Last time I
contacted them, they required an NDA, even though they weren't actually
Linux-hostile. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
