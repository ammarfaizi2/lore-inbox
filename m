Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319375AbSIKW4y>; Wed, 11 Sep 2002 18:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319376AbSIKW4y>; Wed, 11 Sep 2002 18:56:54 -0400
Received: from hq.alert.sk ([147.175.66.131]:57797 "EHLO hq.alert.sk")
	by vger.kernel.org with ESMTP id <S319375AbSIKW4x>;
	Wed, 11 Sep 2002 18:56:53 -0400
Date: Thu, 12 Sep 2002 01:01:38 +0200
From: Robert Varga <nite@hq.alert.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS?
Message-ID: <20020911230138.GA29574@hq.alert.sk>
References: <p73wupuq34l.fsf@oldwotan.suse.de> <200209101518.31538.nleroy@cs.wisc.edu> <20020911084327.GF6085@pegasys.ws> <200209110820.36925.nleroy@cs.wisc.edu> <20020911212146.GC10315@pegasys.ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20020911212146.GC10315@pegasys.ws>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2002 at 02:21:46PM -0700, jw schultz wrote:
> On Wed, Sep 11, 2002 at 08:20:36AM -0700, Nick LeRoy wrote:
> > On Wednesday 11 September 2002 01:43, jw schultz wrote:
> > I think this is a wonderful feature, albeit potentially confusing to a =
Newbie  =20
> > For my O2 running IRIX I get XFS whether I like it or not, for Solaris =
I get=20
> > UFS no matter how much it sucks (I'm not really saying that it does; I =
don't=20
> > have much knowledge of it to be honest).  This multitude of choices rea=
lly=20
> > causes competition between them, and makes them all better in the long =
run.
>=20
> On Solaris and some other platforms you can, with lots of
> money, buy a license to run the Veritas journaling
> filesystem.  It comes with a license manager and you have to
> get license keys to mount the filesystems.  Ever had a
> filesystem not come up after a reboot because the license
> expired, i have (ouch, i told management to renew the
> license).  Is veritas fast? I don't know.  They hype the
> journaling, not speed.  And what are you going to benchmark
> against?.

Against UFS, of course [1] :-) Their hype is "our journal is faster than
UFS", which is probably true. They have extent-based allocation,
which is good for their greatest hype - performance with databases
(see all the marketing shredder-food about [Cached] QuickIO).
They have hot resizing, which fast as hell (again, compared to UFS),
they have snapshots, which are cool. And don't forget the GFS capability,
which I am yet to see in action. [2]

So in Solaris world, for large filesystems, Veritas is the winner. I am
really looking forward to seeing how will they do in the OpenSource
world.

[1] Actually they benchmark Oracle on raw devices vs. Cached QuickIO, too.
[2] Even tough the options are expensive, in my experience all of them
work perfectly.

--=20
Kind regards,
Robert Varga
---------------------------------------------------------------------------=
---
n@hq.sk                                          http://hq.sk/~nite/gpgkey.=
txt

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9f8tS9aKR2/T45h8RAuNCAJ0QugBbW6hnnZxabD4TKUYdiWbfEACfZhgZ
C9klZGag2TKqjlRFTWgb/nk=
=Fr1k
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
