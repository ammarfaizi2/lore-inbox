Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267019AbUBGSki (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 13:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267022AbUBGSki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 13:40:38 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:57738 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267019AbUBGSkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 13:40:36 -0500
Message-ID: <40253119.8030802@yahoo.es>
Date: Sat, 07 Feb 2004 13:40:25 -0500
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Rutherford <mark@justirc.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.2-mm1 / 2.6.2] nforce2 oops at startup, other oddities
References: <200402071321.18352.mark@justirc.net>
In-Reply-To: <200402071321.18352.mark@justirc.net>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig323C79DB0D88B3009271F886"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig323C79DB0D88B3009271F886
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mark Rutherford wrote:
> Hi all,
> Just got my nforce2 board. and everything is working, sorta.
[SNIP]
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y

I don't know about your specific board, but mine is a Biostar M7NCDPro.
I had to update the BIOS to the 1208 BIOS, as tho 1007 BIOS sucked and
caused numerous oopses on boot.

There have also been numeruos issues with the AMD/nForce2 combo because
of the APIC.  There are APIC patches available, or you can simply
disable APIC support altogether.  Search the archives for the numeruos
discussions over the past several months which explain this issue in far
greater detail than I can.

-Roberto

--------------enig323C79DB0D88B3009271F886
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAJTEiTfhoonTOp2oRAvSkAJ4m1QHGE568cLJcOpNgesOdI8xdRwCfXmO9
bXTOLvaUxxrsfrO4xyOYE9M=
=xT6O
-----END PGP SIGNATURE-----

--------------enig323C79DB0D88B3009271F886--
