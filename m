Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWJCOUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWJCOUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWJCOUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:20:09 -0400
Received: from cweiske.de ([80.237.146.62]:63910 "EHLO mail.cweiske.de")
	by vger.kernel.org with ESMTP id S932230AbWJCOUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:20:07 -0400
Message-ID: <452271BA.5040105@cweiske.de>
Date: Tue, 03 Oct 2006 16:20:42 +0200
From: Christian Weiske <cweiske@cweiske.de>
User-Agent: My own hands[TM] Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Christian Weiske <cweiske@cweiske.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference
 at virtual address 000,0000a
References: <45155915.7080107@cweiske.de>	<20060923134244.e7b73826.akpm@osdl.org>	<451677FE.2070409@cweiske.de>	<20060924095029.0262a2c8.akpm@osdl.org>	<4516C4B9.5010509@cweiske.de>	<451821C9.6020602@cweiske.de> <20060925142630.fb39a613.akpm@osdl.org> <452145D0.5000308@cweiske.de>
In-Reply-To: <452145D0.5000308@cweiske.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF6A8B0E0E83470AC79F03A39"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6A8B0E0E83470AC79F03A39
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all,

>> Is it?  I don't recall us having established that.  Does the machine r=
un
>> any earlier kernel without failing?
> I am now trying to get a small disk that is not accessed via the pci id=
e
> card, perhaps that brings more info.

So, after testing two more days I can say the following:
I mirrored the partitions from the 300gb drive to a 6gb one.
The error does not occur on the small disk, neither when directly
connected to the motherboard's ide channel, nor when used through the
pci card (which was my hope). And although SMART says everything is ok,
it seems to me as if the harddrive is broken somehow. Great.

Thanks for all your help!

--=20
Regards/MfG,
Christian Weiske


--------------enigF6A8B0E0E83470AC79F03A39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFFInG9FMhaCCTq+CMRAisuAJ9AwJYCXggsdk9/g4/A/5rMJjI8SgCfbmZq
w4DXG3dTqiNbH/gF2APAHpg=
=nlXL
-----END PGP SIGNATURE-----

--------------enigF6A8B0E0E83470AC79F03A39--
