Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbUAFTwf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 14:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUAFTwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 14:52:35 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:13805 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S264963AbUAFTwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 14:52:33 -0500
Date: Tue, 6 Jan 2004 20:52:25 +0100
From: martin f krafft <madduck@madduck.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem booting aic7xxx-old with reiserfs
Message-ID: <20040106195225.GA12262@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1aMb6-3Fs-37@gated-at.bofh.it> <20040106084152.7B47D52003@chello062178157104.9.14.vie.surfer.at> <20040106084728.GA3094@piper.madduck.net> <20040106093926.GA5904@piper.madduck.net> <2263062704.1073407695@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <2263062704.1073407695@aslan.scsiguy.com>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Justin T. Gibbs <gibbs@scsiguy.com> [2004.01.06.1748 +0100]:
> This means that Domain Validation was unable to probe the your
> Quantum Fireball correctly.  For me to understand why, you need to
> compile the driver with debugging enabled and the debug mask set
> to 0x3F. Both of these settings can be performed via the standard
> kernel configuration tools.  Just boot with those settings and
> send me the complete boot output.  You may need to increase the
> size of your dmesg buffer for all of the output to be recorded.

With debug level to 0x3f (decimal 63) and debugging code enabled,
the resulting boot messages are captured here:

  ftp://ftp.madduck.net/scratch/dmesg-aic7xxx-debug.gz [3.5 Kb]

Another peculiarity: if I soft reset the machine from within 2.6.0
and then start 2.6.0 again, it gets stuck again after the

  found reiserfs format "3.6" with standard journal

message, this time logging furiously to the console. I will verify
this again and let it run forever (with maximum kernel buffer size)
in the hope that you can do something with that too. You'll hear
=66rom me.

Thanks for your time.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"alle vorurteile kommen aus den eingeweiden."
                                                 - friedrich nietzsche

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+xH5IgvIgzMMSnURAh8MAKCQMlm37nXwMc7SyIIy8v71hrHP+gCguqQw
j0X3qzRXFngRSMb6FVqonWo=
=DXJt
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
