Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129935AbRB0X3Z>; Tue, 27 Feb 2001 18:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRB0X3P>; Tue, 27 Feb 2001 18:29:15 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:1543 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129935AbRB0X3B>; Tue, 27 Feb 2001 18:29:01 -0500
Date: Tue, 27 Feb 2001 23:28:54 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: timing out on a semaphore
Message-ID: <20010227232854.Z13721@redhat.com>
In-Reply-To: <20010225224039.W13721@redhat.com> <3A9990EF.8D4ECF49@uow.edu.au> <20010227143942.C13721@redhat.com> <3A9C2CE3.ABA1A6A6@uow.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="3h+hNn3PVp185ISI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A9C2CE3.ABA1A6A6@uow.edu.au>; from andrewm@uow.edu.au on Tue, Feb 27, 2001 at 10:40:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3h+hNn3PVp185ISI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 27, 2001 at 10:40:35PM +0000, Andrew Morton wrote:

> 1: Your code is leaving the semaphore in a down'ed state
>    somehow.

This was probably it.  I don't know why it works for me but not some
other people though. :-/

> (As you can tell, I'm desparately avoiding having
> to understand the semaphore code again :))

:-)

Tim.
*/

--3h+hNn3PVp185ISI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6nDg1ONXnILZ4yVIRAgAfAKCbAL+dyJ9Mu+dCn0VW0whC1KfjDACfQzgF
/yJ379IjKOACEm+aCh1CGYk=
=LWrv
-----END PGP SIGNATURE-----

--3h+hNn3PVp185ISI--
