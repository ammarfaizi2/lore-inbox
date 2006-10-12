Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422711AbWJLOho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWJLOho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422710AbWJLOho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:37:44 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:50053 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S1422706AbWJLOhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:37:43 -0400
Date: Thu, 12 Oct 2006 10:37:26 -0400
From: Will Simoneau <simoneau@ele.uri.edu>
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
Message-ID: <20061012143726.GD21243@ele.uri.edu>
Mail-Followup-To: David Miller <davem@davemloft.net>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
References: <20061005211543.GA18539@ele.uri.edu> <20061009.183607.63736982.davem@davemloft.net> <20061010132943.GB18539@ele.uri.edu> <20061010.151751.90998930.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <20061010.151751.90998930.davem@davemloft.net>
User-Agent: Mutt/1.5.13 [Linux 2.6.18 sparc64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15:17 Tue 10 Oct     , David Miller wrote:
> From: Will Simoneau <simoneau@ele.uri.edu>
> Date: Tue, 10 Oct 2006 09:29:43 -0400
>=20
> > I still get:
> >=20
> > Kernel unaligned access at TPC[10162164] ether1394_reset_priv+0x2c/0xe0=
 [eth1394]
> > Kernel unaligned access at TPC[10163148] ether1394_data_handler+0xdd0/0=
x1060 [eth1394]
> >=20
> > The second one triggers on every packet received, the first only trigge=
rs once in a while.
> >=20
> > If you want more gdb info or a disassembly just ask.
>=20
> Hmmm, can you do me a favor?  Build ieee1394 and eth1394 statically
> into your kernel, reproduce, and post the kernel log messages
> and the vmlinux image somewhere where I can fetch them.
>=20
> I should be able to fix this once I have that.
>=20
> Thanks a lot.

This will be difficult as the machine in question isn't one I want to
reboot too often. The running kernel and modules are compiled with debug
info, though; if I send you the relevant .o files will that help?

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFLlMmLYBaX8VDLLURAuNAAKCATrgdjdySNlWjaZ02vhUfBI1r3gCgi+Uz
k4DFen7DOnHjJjBkeBo2ORw=
=tvSH
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
