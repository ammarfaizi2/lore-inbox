Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293717AbSB1UDC>; Thu, 28 Feb 2002 15:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293713AbSB1T7k>; Thu, 28 Feb 2002 14:59:40 -0500
Received: from [65.169.83.229] ([65.169.83.229]:18318 "EHLO
	hst000004380um.kincannon.olemiss.edu") by vger.kernel.org with ESMTP
	id <S293723AbSB1T6i>; Thu, 28 Feb 2002 14:58:38 -0500
Date: Thu, 28 Feb 2002 13:57:42 -0600
From: Benjamin Pharr <ben@benpharr.com>
To: Nathan Walp <faceprint@faceprint.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.5-dj1 - Bug Reports
Message-ID: <20020228195742.GA20106@hst000004380um.kincannon.olemiss.edu>
In-Reply-To: <20020221233700.GA512@hst000004380um.kincannon.olemiss.edu> <20020222022149.N5583@suse.de> <20020222063721.GA8879@faceprint.com> <20020228165951.GA4014@faceprint.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20020228165951.GA4014@faceprint.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19pre1
X-PGP-ID: 0x6859792C
X-PGP-Key: http://www.benpharr.com/public_key.asc
X-PGP-Fingerprint: 7BF0 E432 3365 C1FC E0E3  0BE2 44E1 3E1E 6859 792C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2002 at 11:59:54AM -0500, Nathan Walp wrote:
> On Fri, Feb 22, 2002 at 01:37:24AM -0500, Nathan Walp wrote:
> > On Fri, Feb 22, 2002 at 02:21:49AM +0100, Dave Jones wrote:
> > >  > It compiled fine. When I booted up everything looked normal with t=
he
> > >  > exception of a=20
> > >  > eth1: going OOM=20
> > >  > message that kept scrolling down the screen. My eth1 is a natsemi =
card.
> > >=20
> > >  That's interesting. Probably moreso for Manfred. I'll double check
> > >  I didn't goof merging the oom-handling patch tomorrow.
> >=20
> > Ditto here on my natsemi.  It hasn't really spit out the error since
> > boot, about 12 hours ago.  Card has been mainly idle, only used to
> > connect via crossover cable to my laptop, which hasn't been used much in
> > that time.
>=20
> dj2 is showing the same behavior, but I found out that the messages
> continue to be printed 100 times/second until I ping-flooded the machine
> on the other end of that card.  The minimal DHCP traffic prior to the
> ping flood was not enough to make it stop.
>=20
> Hope this helps narrow down the problem some.

My box continued to do it until ntpdate contacted its servers, so it
appears to be basically the same thing.

Ben Pharr




--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fou2ROE+HmhZeSwRArIKAJ0USGBBC+B9s6z8qsT/Scfv7EpzAwCgsjmR
8Duu2D5xeALdaFNHbAryPSs=
=gGJ9
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
