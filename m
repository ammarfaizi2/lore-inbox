Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVEKUlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVEKUlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVEKUlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:41:42 -0400
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:50845 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S261218AbVEKUlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:41:36 -0400
Date: Wed, 11 May 2005 16:38:45 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix long-standing bug in 2.6/2.4 skb_copy/skb_copy_expand
Message-ID: <20050511203845.GA10770@shaftnet.org>
References: <20050508143259.GA30676@shaftnet.org> <E1DUyZO-0004Fp-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <E1DUyZO-0004Fp-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.1i
X-milter-date-PASS: YES
X-milter-7bit-Pass: YES
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2005 at 01:04:34PM +1000, Herbert Xu wrote:
> > This is, fortunately, generally true.  But if the alloc_skb function=20
> > allocates extra head room (ie calls skb_reserve() on the skb before it=
=20
> > passes it to the callee, this doesn't quite work.  Instead, it should b=
e=20
> > rewritten as:
>=20
> As far as I know the alloc_skb funciton in the kernel tree doesn't do
> that so your patch is not necessary unless we decide to change the way
> alloc_skb works.  If that's what you want then please provide a patch
> to alloc_skb and a rationale as to why we should do that.

It does not, and I have no intention of submitting a patch to change it.=20
As I said in my original message, it was a crude hack which has since
been relegated to the great bitbucket of the sky.  All that's left is
that "bugfix" patch.

I've performed my due-diligence in airing it to the powers that be, so=20
I'll go way now.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					 JID: pitha@myjabber.net
Quidquid latine dictum sit, altum viditur

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCgm1VPuLgii2759ARAp58AJ0YTlpIfHfZzO1FPsrKwvO/nkSDMwCg34Fy
oyb6OWUtCSERK967FUx7Pks=
=vclu
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
