Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWGSVOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWGSVOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 17:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWGSVOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 17:14:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:53485 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030315AbWGSVOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 17:14:04 -0400
Date: Wed, 19 Jul 2006 23:14:02 +0200
From: Torsten Landschoff <torsten@debian.org>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS breakage in 2.6.18-rc1
Message-ID: <20060719211402.GA1133@stargate.galaxy>
References: <20060718222941.GA3801@stargate.galaxy> <20060719085731.C1935136@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20060719085731.C1935136@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:d638a0eb9c9fbc21c426336ab6dfa19b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,=20

On Wed, Jul 19, 2006 at 08:57:31AM +1000, Nathan Scott wrote:
=20
> I suspect you had some residual directory corruption from using the
> 2.6.17 XFS (which is known to have a lurking dir2 corruption issue,
> fixed in the latest -stable point release).

That probably the cause of my problem. Thanks for the info!

BTW: I think there was nothing important on the broken filesystems, but
I'd like to keep what's still there anyway just in case... How would you
suggest should I copy that data? I fear, just mounting and using cp=20
might break and shutdown the FS again, would xfsdump be more
appropriate?

Thanks for XFS, I am using it for years in production servers!

Greetings

	Torsten

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEvqCadQgHtVUb5EcRAoJLAJ4jJaYRxbnNVCEZBJuki2kTz2VtQwCfd2Mq
9BasGncq2cRLpRTp5wU9EMM=
=NS5n
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
