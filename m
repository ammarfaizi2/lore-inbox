Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261984AbSIYOW4>; Wed, 25 Sep 2002 10:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261985AbSIYOW4>; Wed, 25 Sep 2002 10:22:56 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44382 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S261984AbSIYOWz>; Wed, 25 Sep 2002 10:22:55 -0400
Date: Wed, 25 Sep 2002 15:27:57 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Steve Underwood <steveu@coppice.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB IEEE1284 gadgets and ppdev
Message-ID: <20020925142757.GL9457@redhat.com>
References: <3D90831A.7060709@coppice.org> <20020924162130.GE9457@redhat.com> <3D91BF58.8080803@coppice.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8xFSaDOZv3KW7q+m"
Content-Disposition: inline
In-Reply-To: <3D91BF58.8080803@coppice.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8xFSaDOZv3KW7q+m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2002 at 09:51:20PM +0800, Steve Underwood wrote:

> As far as I can tell there are only two USB drivers for USB-to-IEEE1284=
=20
> devices - USS720 for the USS720 device, and usblp for everything else.=20
> Is usblp supposed to hook into ppdev? Is there some other device driver=
=20
> I missed?

Not into ppdev; into parport.  It ought to use
parport_register_port. (It doesn't, currently.)

Tim.
*/

--8xFSaDOZv3KW7q+m
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9kcfttO8Ac4jnUq4RAtdVAJ9nbIUrrNOR3cG+SKJP3A77yJUp1QCfUtXa
iDgSSZd/id48TRrzsLfJsqY=
=n0Dj
-----END PGP SIGNATURE-----

--8xFSaDOZv3KW7q+m--
