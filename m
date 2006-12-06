Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760243AbWLFGVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760243AbWLFGVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760248AbWLFGVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:21:24 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:53662 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760247AbWLFGVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:21:23 -0500
Date: Wed, 6 Dec 2006 17:21:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: albertl@mail.com
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Oops in pata_pdc2027x
Message-Id: <20061206172114.a1c515f8.sfr@canb.auug.org.au>
In-Reply-To: <45765EC7.2000908@tw.ibm.com>
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
	<45765EC7.2000908@tw.ibm.com>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 06 Dec 2006 14:10:15 +0800 Albert Lee <albertcc@tw.ibm.com> wrote:
>
> Where could I download the patched kernel source? There are two
> POWER5 9110-51A boxes here. Maybe I could try to reproduce the problem
> on these boxes.

You can just use Linus' current tree - it exhibits the same problem (and
the powerpc tree has been merged into it).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFdmFaFdBgD/zoJvwRAlrrAJ9nTsXfOmskR8L8mTwmI4mp8C65KwCgmDUe
HB9+ck7EU3PHukwX4zzUs20=
=OW9h
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv--
