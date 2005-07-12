Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVGLVeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVGLVeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVGLVeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:34:00 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:46586 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262432AbVGLVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:32:25 -0400
Subject: Re: [openib-general] Re: [PATCH 3/27] Add MAD helper functions
From: Tom Duffy <tduffy@sun.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       Hal Rosenstock <halr@voltaire.com>
In-Reply-To: <200507112238.27856.adobriyan@gmail.com>
References: <1121089079.4389.4511.camel@hal.voltaire.com>
	 <200507111839.41807.adobriyan@gmail.com> <42D2B1F1.7000408@sun.com>
	 <200507112238.27856.adobriyan@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-g0BWh50xghtjubrI/v2O"
Date: Tue, 12 Jul 2005 14:32:14 -0700
Message-Id: <1121203934.14638.27.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-11.fc5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g0BWh50xghtjubrI/v2O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-07-11 at 22:38 +0400, Alexey Dobriyan wrote:
> $ make allmodconfig >/dev/null
> $ make C=3D2 CHECK=3D"sparse -Wbitwise" drivers/infiniband/ 2>&1 | tee ..=
/W_infiniband
> 	[snip]
> $ grep -c "warning: " ../W_infiniband
> 430

These seem to be mostly coming from cpu_to_be*() and be*_to_cpu().  Is
there a good rule of thumb for fixing these warnings?

Thanks,

-tduffy

--=-g0BWh50xghtjubrI/v2O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1DbedY502zjzwbwRAiFOAJ46YN78c3tfENRRN9XakEmgA8+Z3gCZAW4C
931Z28Yzsn/dCj3Co34L8FY=
=bwJO
-----END PGP SIGNATURE-----

--=-g0BWh50xghtjubrI/v2O--
