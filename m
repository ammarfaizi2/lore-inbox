Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbUALOMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbUALOMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:12:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6587 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265514AbUALOL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:11:59 -0500
Date: Mon, 12 Jan 2004 15:11:41 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Peschke3 <MPESCHKE@de.ibm.com>
Cc: Doug Ledford <dledford@redhat.com>, Jens Axboe <axboe@suse.de>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040112141141.GB25249@devserv.devel.redhat.com>
References: <OF2581AA2D.BFD408D2-ONC1256E19.004BE052-C1256E19.004E1561@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <OF2581AA2D.BFD408D2-ONC1256E19.004BE052-C1256E19.004E1561@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon, Jan 12, 2004 at 03:07:55PM +0100, Martin Peschke3 wrote:
> Hi,
>=20
> is there a way to merge all (or at least the common denominator) of
> Red Hat's and SuSE's changes into the vanilla 2.4 SCSI stack?

Since 2.4 is basically frozen, and said patches are only performance
optimisations and not functionality enhancements I would think this is a bad
idea; if you need the small performance gain, 2.6 is imo a far better place
nowadays. The 2.4 SCSI stack seems rather stable and destabilizing it this
late in the cycle sounds bad with the alternative of 2.6 being available.

Greetings,
    Arjan van de Ven
--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAAqscxULwo51rQBIRAoXHAJ9DbWjpCXyuQgx5o8HcfRWUnRxGqACfSS36
oOUMNVH+lRx0MDXbEQaOBFg=
=GbjA
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
