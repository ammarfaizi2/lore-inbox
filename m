Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTLIFx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 00:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTLIFx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 00:53:59 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:38073 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263102AbTLIFx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 00:53:57 -0500
Message-ID: <3FD56330.6040506@yahoo.es>
Date: Tue, 09 Dec 2003 00:52:48 -0500
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.0-testX show stoppers
References: <3FD498A0.9080802@yahoo.es> <1070898030.2098.146.camel@athlonxp.bradney.info> <3FD4B250.8010402@nishanet.com>
In-Reply-To: <3FD4B250.8010402@nishanet.com>
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig167B16ED25EC5FFD32B5A2B8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig167B16ED25EC5FFD32B5A2B8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bob wrote:
> Craig Bradney wrote:
> 
>> For the Athlon, keep in touch with the nforce thread on here.. There are
>> patches due to timing issues with the nforce chipset.
>> For me, so far, just using this one works:
>> http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-apic.patch 
[SNIP]
> The patch works for a lot of people. I've seen those drive
> errors, irq7 disabled, spurious 8259a messages with a
> bios and acpi and apic and lapic and linux acpi handling
> conflict usually related to nforce2 and amd cpu's are
> usually involved.
> 
> My nforce2 amd system got to working with apic and lapic
> and acpi when I did a bios flash update.

I also tried flashing the BIOS, but that was a complete disaster.
I have a BioStar motherboard (M7NCD Pro), and when I flashed to the 1007
BIOS, I started getting segfaults during init, was unable to log in most
times, and the machine was generally unusable.

When I reflashed to the (old) 0630 BIOS, the above patch worked its
magic.

Incidentally, everyone should stay away from the 1007 BIOS for the
M7NCD Pro.

-Roberto

--------------enig167B16ED25EC5FFD32B5A2B8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/1WMwTfhoonTOp2oRAp7TAJ9PLbrC1DqyHuLlekxOblEgNXWTmwCfQvtk
s+v0Noeh8hoXAtrTWNHAdOE=
=SVsM
-----END PGP SIGNATURE-----

--------------enig167B16ED25EC5FFD32B5A2B8--

