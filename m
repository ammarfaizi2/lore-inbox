Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131544AbRDCKXG>; Tue, 3 Apr 2001 06:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131564AbRDCKW4>; Tue, 3 Apr 2001 06:22:56 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:36183 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131595AbRDCKWm>; Tue, 3 Apr 2001 06:22:42 -0400
Date: Tue, 3 Apr 2001 11:21:51 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Allen Ashley <ashley@alumni.caltech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.15 kernel bug report
Message-ID: <20010403112151.L1268@redhat.com>
In-Reply-To: <200104030853.BAA00238@aa.home.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="GeDkoc8jIzHasOdk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104030853.BAA00238@aa.home.org>; from ashley@alumni.caltech.edu on Tue, Apr 03, 2001 at 01:53:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GeDkoc8jIzHasOdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 03, 2001 at 01:53:26AM -0700, Allen Ashley wrote:

> ---------------------------------------------------------------
> soval=fcntl(s,F_GETFL,0);
> ioval=fcntl(0,F_GETFL,0);
> fcntl(s,F_SETFL,soval|O_NONBLOCK);
> fcntl(0,F_SETFL,ioval|O_NONBLOCK);
> cwait=WAITCONNECT;
> *chin=0;
> do{
> /*If the following line is commented out the program does not crash*/
> 	rval=connect(s, (struct sockaddr *)&dst, sizeof(dst));

You haven't mentioned dst before this line, or s.  Make a small,
complete, minimal test program that shows the bug.

Tim.
*/

--GeDkoc8jIzHasOdk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6yaQ+ONXnILZ4yVIRAkfSAJ9AWYvVwOr9uzZ03p2dR1Kea5EJDQCcDd1U
9puEz7592eG73SnEbUfJ4W8=
=CG3I
-----END PGP SIGNATURE-----

--GeDkoc8jIzHasOdk--
