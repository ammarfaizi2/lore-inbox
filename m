Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135613AbRDSK1M>; Thu, 19 Apr 2001 06:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135614AbRDSK1C>; Thu, 19 Apr 2001 06:27:02 -0400
Received: from gadget.lut.ac.uk ([158.125.96.50]:33552 "EHLO gadget.lut.ac.uk")
	by vger.kernel.org with ESMTP id <S135613AbRDSK0o>;
	Thu, 19 Apr 2001 06:26:44 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac7 
In-Reply-To: Message from "Grover, Andrew" <andrew.grover@intel.com> 
   of "Wed, 18 Apr 2001 11:54:16 PDT." <4148FEAAD879D311AC5700A0C969E89006CDDD9B@orsmsx35.jf.intel.com> 
Date: Thu, 19 Apr 2001 11:23:30 +0100
From: Martin Hamilton <martin@net.lut.ac.uk>
Message-Id: <E14qBb0-00009l-00@gadget.lut.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

"Grover, Andrew" writes:

| I don't think I understand that first sentence. (Let me respond anyways ;-)

Doh!  Sorry, what I meant was that (if I'm understanding this right!)
the AML interpreter being embedded in the kernel in 2.4.x is Intel's
platform-independent solution to the problem of providing support for
ACPI under Unix, so that you don't have to code up ACPI stuff
independently for the vagaries of each Unix variant's kernel.

So, it's good for you, but not necessarily optimal for any particular 
Unix variant, right ?  e.g. this could perhaps be simplified 
somewhat..

  [root@porcupine acpi]# pwd
  /usr/src/linux-2.4.3-ac9-swsusp-jogutils/drivers/acpi
  [root@porcupine acpi]# wc -l `find . -type f` | grep total
    59435 total

My gripe is taken care of now, though - swsusp is working :-)

Cheers,

Martin




-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 + martin

iD8DBQE63ryhVw+hz3xBJfQRAkzDAJ9eVSJUK7mPZqUyqpvl/yOJSkiAsQCeJjtN
153+/FDFzNKht/7iTKYSI0k=
=0C2p
-----END PGP SIGNATURE-----

