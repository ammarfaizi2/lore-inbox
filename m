Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRDQKfu>; Tue, 17 Apr 2001 06:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRDQKfk>; Tue, 17 Apr 2001 06:35:40 -0400
Received: from gadget.lut.ac.uk ([158.125.96.50]:20495 "EHLO gadget.lut.ac.uk")
	by vger.kernel.org with ESMTP id <S131376AbRDQKfZ>;
	Tue, 17 Apr 2001 06:35:25 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac7 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Mon, 16 Apr 2001 13:57:34 BST." <E14p8ZV-0000C1-00@the-village.bc.nu> 
Date: Tue, 17 Apr 2001 11:35:23 +0100
From: Martin Hamilton <martin@net.lut.ac.uk>
Message-Id: <E14pSpQ-00022n-00@gadget.lut.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Alan Cox writes:

| Adding a bloated interpreter for an obscure, misdesigned bios hardware
| description language is simply not my idea of progress. 

Pardon me for butting in, but perhaps this is relevant...

I've seen the odd program which manipulates the ACPI tables/registers
directly rather than through an ASL compiler then an AML interpreter.
These appear to use the "magic numbers" which the interpreter would
eventually spit out.

Being a newbie on ACPI internals (still ploughing through the 400 page
'specification' document), I'm not sure whether there would be nasty
implications from doing this on a larger scale - e.g. needing to tweak
those magic numbers for each and every ACPI BIOS implementation.

Back in the real world, some people using ACPI BIOSes (e.g. owners of
recent Sony Vaio boxes like my C1VE) are finding that the legacy APM
support is losing when they try to do things like suspend to disk.  A
minimalist ACPI implementation could be just the ticket...

Just wondering if people have any thoughts on this!

Cheers,

Martin

PS Blatant plug :-)  I've set up a mailing list for people doing Linux
stuff on the Sony C1's:  http://mail.gnu.org/mailman/listinfo/linux-c1



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 + martin

iD8DBQE63BxrVw+hz3xBJfQRAhZEAJ9wYOmOpbaA4z0qZpSmn43IGJJZdgCfbLo7
L9ZG4E/Z97LI87u5iK+TOvY=
=/ItG
-----END PGP SIGNATURE-----

