Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268144AbTB1Uhs>; Fri, 28 Feb 2003 15:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268147AbTB1Uhs>; Fri, 28 Feb 2003 15:37:48 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:36398 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S268144AbTB1Uhq>;
	Fri, 28 Feb 2003 15:37:46 -0500
Message-ID: <3E5FCB05.6070806@acm.org>
Date: Fri, 28 Feb 2003 14:48:05 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: ACPI request/release generic address
References: <F760B14C9561B941B89469F59BA3A84725A1B9@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A1B9@orsmsx401.jf.intel.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Grover, Andrew wrote:

|>From: Jeff Garzik [mailto:jgarzik@pobox.com]
|>Can you define a generic address?
|>
|>IIRC, ACPI needs some work in this area.
|>
|>If the "generic address" is host RAM, that's easy.
|>If the generic address is PIO address, that's mostly easy.
|>If the generic address is MMIO address, that takes a bit of care with
|>mapping, and I'm not sure ACPI gets it right in these cases.
|
|
|The Generic Address Structure (GAS) is basically a 64 bit address and a
|type field. The type can be:
|
|System memory
|System IO
|PCI Config space
|Embedded Controller
|SMBus
|Functional fixed hardware
|
|I don't think this will very easily handle a clean request/release API.
|Corey, what is the specific table you are concerned with? At least with
|the GASes ACPI uses internally, they point to resource regions already
|marked as used via other means (e820 or _CRS, for example.)

This is for some IPMI (Intelligent Platform Management Interface) hardware.
It's address is specified in an ACPI table.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+X8sDIXnXXONXERcRAraPAKCnPI1C7hfugkYVl0EOskoW2Tg61QCdHcfA
YnQrVlzYyYJssPU58cY4NU0=
=0Fqf
-----END PGP SIGNATURE-----


