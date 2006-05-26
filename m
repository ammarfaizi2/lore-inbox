Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWEZQPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWEZQPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWEZQPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:15:06 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:3974 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750700AbWEZQPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:15:04 -0400
Date: Fri, 26 May 2006 11:14:54 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mike@halcrow.us>
Subject: Re: [PATCH 1/10] Convert ASSERT to BUG_ON
Message-ID: <20060526161454.GC2764@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060526142117.GA2764@us.ibm.com> <E1FjdCG-000335-IS@localhost.localdomain> <20060526152401.GF17337@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20060526152401.GF17337@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2006 at 05:24:01PM +0200, Adrian Bunk wrote:
> On Fri, May 26, 2006 at 09:21:48AM -0500, Mike Halcrow wrote:
> > -	ASSERT(auth_tok->session_key.encrypted_key_size < PAGE_CACHE_SIZE);
> > +	BUG_ON(auth_tok->session_key.encrypted_key_size > PAGE_CACHE_SIZE);
> >...
>=20
> What's with (auth_tok->session_key.encrypted_key_size =3D=3D
> PAGE_CACHE_SIZE) ?

That should not be a problem.

Mike

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUBRHcpfttAhTFtyodpAQLvEAf/faHOBw0pr0cvix8qwObLWkKk4RD+Iusf
TpjJZ+zAprlGGm0+1ELFQjb2c0fTP3QwiiQ/5fHCLgfiJ8GMaRJm4d7bTRZqu0Ug
HER/FYr4ovP1w+R5qWepjIENtdAhqEaMIYTNIr9NgVFk0aTYP5G11tmIwYMvoDe7
eyq4w5Q5Mj132TMGYATFZziesYl9MxfAaap5br7WV4zJkWJ1pE8/HS5+CRE1peW5
8x3Em9kXg63APj3yjQIGn/Xx4UW7W8AHaoQgniVqu2T7EZ+tWonTMkkWZsgMVrsZ
upw9WDlVMSEVxBv7y0a8l27E03JWPDbgiT8JB3MYlNj4tvyNxBOkSA==
=TBxI
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
