Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132747AbRDINjX>; Mon, 9 Apr 2001 09:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132749AbRDINjN>; Mon, 9 Apr 2001 09:39:13 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:3968 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132747AbRDINjA>; Mon, 9 Apr 2001 09:39:00 -0400
Date: Mon, 9 Apr 2001 14:38:54 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport initialisation
Message-ID: <20010409143854.K1136@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1010409141107.9826A-100000@medusa.sparta.lu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010409141107.9826A-100000@medusa.sparta.lu.se>; from bjorn@sparta.lu.se on Mon, Apr 09, 2001 at 02:13:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2001 at 02:13:10PM +0200, Bjorn Wesen wrote:

> Is it just because nobody has gotten around to "fixing" it or is there a
> deeper reason ?

There's no deeper reason.  But there are dependencies involved:
parport needs to be initialised before any parport lowlevel drivers,
and they need to be initialised before things like lp and ppdev.

Tim.
*/

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE60bttONXnILZ4yVIRAvCBAJ4pta3FwVw8TB8OosB6aq589ZGBKwCfXqG6
x6u5OQ//3DluHBVC+oqIRLo=
=8exG
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--
