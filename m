Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277265AbRJNSUS>; Sun, 14 Oct 2001 14:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277264AbRJNSUH>; Sun, 14 Oct 2001 14:20:07 -0400
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:27613 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S277263AbRJNSTw>; Sun, 14 Oct 2001 14:19:52 -0400
Date: Sun, 14 Oct 2001 20:19:07 +0200
From: Jens Benecke <jens@jensbenecke.de>
To: linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [reiserfs-list] Re: ReiserFS data corruption in very simple configuration
Message-ID: <20011014201907.H20001@jensbenecke.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Reiserfs mail-list <Reiserfs-List@namesys.com>
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu> <15276.34915.301069.643178@beta.reiserfs.com> <20010924112510.F15955@jensbenecke.de> <2143070000.1003071174@tiny>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <2143070000.1003071174@tiny>; from mason@suse.com on Sun, Oct 14, 2001 at 10:52:54AM -0400
X-FAQ-is-At: http://www.linuxfaq.de/
X-No-Archive: Yes
X-Operating-System: Linux 2.4.10-jb-gr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2001 at 10:52:54AM -0400, Chris Mason wrote:
=20
> > When I was using ext2 I always mounted the /usr partition read-only, so
> > that a fsck weren't necessary at boot - and the files were all
> > guaranteed to be OK to bring the system up at least.
> >=20
> > Does this (mount -o ro) make sense with ReiserFS as well? What I mean
> > is, is there a chance of a file getting corrupted that was only *read*
> > (not *written*) at or before a power outage?
>=20
> Yes, after the mount is finished, reiserfs won't change the files on a
> readonly mount.

What I meant is this: AFAIK, if you exclude broken hardware, in ext2 there
is no chance of a file that was never written to since mounting being
corrupted on a crash, even if the fs was mounted read-write.

Is this the same thing with ReiserFS?


--=20
Jens Benecke =B7=B7=B7=B7=B7=B7=B7=B7 http://www.hitchhikers.de/ - Europas =
Mitfahrzentrale

Crypto regulations will only hinder criminals who obey the law.

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE7ydcb153rQBa8U44RAtf2AJ9EElOmjyAUNdiHtU3kfl70UlzyygCfb1Tc
/hed2+/K5qnLuU0dwQkqW0o=
=at4F
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--
