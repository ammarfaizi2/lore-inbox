Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTKKEDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTKKEDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:03:33 -0500
Received: from relay.pair.com ([209.68.1.20]:11278 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S264255AbTKKEDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:03:30 -0500
X-pair-Authenticated: 68.42.66.6
Subject: Re: OT: why no file copy() libc/syscall ??
From: Daniel Gryniewicz <dang@fprintf.net>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davide.rossetti@roma1.infn.it, filia@softhome.net,
       jesse@cats-chateau.net, dwmw2@infradead.org, moje@vabo.cz,
       kakadu_croc@yahoo.com
In-Reply-To: <20031110205011.R10197@schatzie.adilger.int>
References: <1068512710.722.161.camel@cube>
	 <20031110205011.R10197@schatzie.adilger.int>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xbIS4OSSI8/DUb687L0R"
Message-Id: <1068523406.4156.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 10 Nov 2003 23:03:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xbIS4OSSI8/DUb687L0R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-11-10 at 22:50, Andreas Dilger wrote:
> Having a sys_copy() syscall would be incredibly useful for Lustre
> (distributed Linux fs).  We could start a copy from one storage node
> to another (or more likely many to many for a file striped over many
> storage nodes) at num_stripes * uni-directional bandwidth with no
> impact to the client node.  Instead, we have to copy files at best a
> single client's bi-directional network_bandwidth.

Plus a sys_copy() syscall could be used as a generic way for filesystems
to set up Copy-on-Write.  Right now, you'd need to have userspace call
sys-reiser4 or something like that.
--=20
Daniel Gryniewicz <dang@fprintf.net>

--=-xbIS4OSSI8/DUb687L0R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/sF+OomPajV0RnrERAoMQAJ92zzsTZbr5JtDSAYLDTGtQFPeOCwCdEWSU
Nt0+UCMfEC9jn1CcYRDMUGc=
=s0Cq
-----END PGP SIGNATURE-----

--=-xbIS4OSSI8/DUb687L0R--
