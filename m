Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbVKBLVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVKBLVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 06:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVKBLVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 06:21:49 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:43747 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932586AbVKBLVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 06:21:48 -0500
Date: Wed, 2 Nov 2005 13:21:46 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH consolidate sys_ptrace
Message-ID: <20051102112146.GB14639@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20051101050900.GA25793@lst.de> <20051101051221.GA26017@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20051101051221.GA26017@lst.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2005 at 06:12:21AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 01, 2005 at 06:09:00AM +0100, Christoph Hellwig wrote:
> > Some architectures have a too different ptrace so we have to exclude
> > them.  They continue to keep their implementations.  For sh64 I had to
> > add a sh64_ptrace wrapper because it does some initialization on the
> > first call.  For um I removed an ifdefed SUBARCH_PTRACE_SPECIAL block,
> > but SUBARCH_PTRACE_SPECIAL isn't defined anywhere in the tree.
>=20
> Umm, it might be a good idea to actually send the current patch instead
> of the old one.  I really should write this text from scratch instead
> of copying it :)
>=20
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>=20
sh and sh64 bits look fine, thanks.

Acked-by: Paul Mundt <lethal@linux-sh.org>

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDaKFJ1K+teJFxZ9wRAu/kAJ4+xE34Y9SpqHD1mwAwv1P1YO4vuwCfcWzM
1YYaghhmIfXY0dwXbb/S+eg=
=7bi9
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
