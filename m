Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTJIQk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTJIQk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:40:56 -0400
Received: from newsmtp.golden.net ([199.166.210.106]:28682 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S262310AbTJIQkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:40:52 -0400
Date: Thu, 9 Oct 2003 12:40:48 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sunrpc/clnt.c compile fix
Message-ID: <20031009164048.GA12029@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20031009161350.GA9170@linux-sh.org> <shsr81mnz8i.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <shsr81mnz8i.fsf@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2003 at 12:37:49PM -0400, Trond Myklebust wrote:
>      > This is due to the fact that tk_pid is protected by
>      > RPC_DEBUG. Wrapping through dprintk() fixes this.
>=20
> No... You are suppressing legitimate warning messages that inform the
> user of a client/server mismatch!
>=20
> Better then to remove the tk_pid from the warning messages...
>=20
Is there any reason why tk_pid needs to be under RPC_DEBUG in the first pla=
ce?
If these are legitimate warning messages, presumably it would be nice to kn=
ow
the offending pid as well.


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/hY+Q1K+teJFxZ9wRAvRgAJ46cOKMNz67kKnIJI0FNCitm1y0ugCfZ4Hb
a3QOLLE+LTkbiNAGI5qqccs=
=sUSS
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
