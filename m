Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267951AbTB1SMS>; Fri, 28 Feb 2003 13:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267968AbTB1SMS>; Fri, 28 Feb 2003 13:12:18 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:25902 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S267951AbTB1SMR>;
	Fri, 28 Feb 2003 13:12:17 -0500
Message-ID: <3E5FA8EC.7030607@acm.org>
Date: Fri, 28 Feb 2003 12:22:36 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ACPI request/release generic address
References: <3E5F8DA5.9050804@acm.org> <20030228163253.GB6351@gtf.org>
In-Reply-To: <20030228163253.GB6351@gtf.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It an acpi_generic_address structure defined in include/acpi/actbl2.h.
It's an address that can be in memory, I/O, or PCI configuration space.

The definition is at http://www.microsoft.com/hwdev/tech/onnow/LF-ACPI.asp

- -Corey

Jeff Garzik wrote:

|On Fri, Feb 28, 2003 at 10:26:13AM -0600, Corey Minyard wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Is there a way in the ACPI code to do a request/release of I/O or memory
|>with an acpi_generic_address?  Does it even make sense to do this?
|>There are generic I/O routines for using a generic address, and I'm
|>working with an ACPI table that has a generic address, so it would seem
|>to make sense to have memory reservation routines through this, too.
|
|
|Can you define a generic address?
|
|IIRC, ACPI needs some work in this area.
|
|If the "generic address" is host RAM, that's easy.
|If the generic address is PIO address, that's mostly easy.
|If the generic address is MMIO address, that takes a bit of care with
|mapping, and I'm not sure ACPI gets it right in these cases.
|
|    Jeff
|
|
|

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+X6jqIXnXXONXERcRAtghAKCpyo6enCR91Affkq9lwDRIRQleTwCeIC1t
TlYA0vFQIvYWCKf7IknAG90=
=BG4s
-----END PGP SIGNATURE-----


