Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUGEUih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUGEUih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 16:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUGEUig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 16:38:36 -0400
Received: from dhcp160179209.columbus.rr.com ([24.160.179.209]:35855 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S262079AbUGEUiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 16:38:20 -0400
Date: Mon, 5 Jul 2004 16:38:18 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, benh@kernel.crashing.org
Subject: Re: 2.6.7-mm6 - ppc32 inconsistent kallsyms data
Message-ID: <20040705203818.GA11625@samarkand.rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	benh@kernel.crashing.org
References: <20040705023120.34f7772b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20040705023120.34f7772b.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 05, 2004 at 02:31:20AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7=
-mm6/

  I'm getting this while building for ppc32:
   =20
    Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS

  This didn't happen with -mm5.

  The help text for CONFIG_KALLSYMS_EXTRA_PASS says I should report a
bug, and reads like kallsyms is a utility or part of the toolchain;
I think it's talking about the kernel feature though, so I guess
I'll report it here.  I'll keep this tree around in case any more
information is needed.

  While I'm asking, should I CC Paul Mackerras and/or BenH when reporting b=
uild
problems on my Powermac in the -mm tree?

--
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William G. Perry Jr.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6bw4Wv4KsgKfSVgRAvmqAJ9iP+ehP6oGowz+uA9q4eONLn0rkwCcChVa
WFXjckWzIHRkxbRsCI5IfQE=
=A5uZ
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
