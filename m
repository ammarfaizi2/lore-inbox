Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbTEOIqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 04:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTEOIqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 04:46:30 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:57272 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S263881AbTEOIq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 04:46:28 -0400
Date: Thu, 15 May 2003 10:59:12 +0200
From: Martin Waitz <tali@admingilde.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 laptop mode
Message-ID: <20030515085912.GV1253@admingilde.org>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030514093504.GE17033@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p/1JFEOz/hVXxMAZ"
Content-Disposition: inline
In-Reply-To: <20030514093504.GE17033@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p/1JFEOz/hVXxMAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Wed, May 14, 2003 at 11:35:04AM +0200, Jens Axboe wrote:
> Now, this isn't the prettiest patch in the world. But it does allow me
> to get good spin down times on my laptop hard drive. It was somewhat
> inspired by the 2.5.early version akpm did. Basically, it adds:

if you are interested in spinning down hard drives, you might want to read
http://www4.informatik.uni-erlangen.de/Publications/pdf/Weissel-Beutel-Bell=
osa-OSDI-CoopIO.pdf

they describe strategies to get maximum sleep times for drives by
bundling accesses to hard discs.

they even go a little bit faster and allow user space to give hints
about when they need data.
i only had a brief look at the sources but i guess this could be folded
into the aio interface.
(CoopIO as described above adds its own system calls)
it would be great if somethink like that could be ported to 2.5...


--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 3       _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--p/1JFEOz/hVXxMAZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+w1bej/Eaxd/oD7IRAmdDAJ9APquzXVKr7LNoc94JKIv0aVyQwwCfYU7q
TGyeEdM6NmhX2UjGcpHTh6M=
=OvAT
-----END PGP SIGNATURE-----

--p/1JFEOz/hVXxMAZ--
