Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbSLSSQR>; Thu, 19 Dec 2002 13:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbSLSSQR>; Thu, 19 Dec 2002 13:16:17 -0500
Received: from diamond.madduck.net ([66.92.234.132]:9476 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP
	id <S265828AbSLSSQQ>; Thu, 19 Dec 2002 13:16:16 -0500
Date: Thu, 19 Dec 2002 19:23:59 +0100
From: martin f krafft <madduck@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 'D' processes on a healthy system?
Message-ID: <20021219182359.GA29366@fishbowl.madduck.net>
References: <20021219124043.GA28617@fishbowl.madduck.net> <1040319832.28973.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <1040319832.28973.4.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: Debian GNU/Linux
X-OS: Debian GNU/Linux testing/unstable kernel 2.4.19-grsec+freeswan-fishbowl i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[please continue to CC me]

Thank you for your reply:

also sprach Alan Cox <alan@lxorguk.ukuu.org.uk> [2002.12.19.1843 +0100]:
> Your disk is too slow for the work being asked of it, thats all.
> Eventually it'll get there

Alan, I am in no position to doubt what you say, but I can't imagine
that. Sure, maybe the 5,400 RPM one, but not the 7,200 RPM one.

The reason why I am saying this is twofold and empirical:

  - When the above occurs, the system in question might not be doing
    anything. My example with /usr/sbin/sendmail in a while loop is
    hardcore stresstesting. I have had the problem with no users on
    the system, no requests being served by the servers (ifconfig
    down), just two ssh connections, one displaying top, the other
    opening a Maildir folder of 1,000 messages with mutt. I really
    don't (want to) believe that a system with these specs can't
    handle that.

  - I have another system with exactly the same specs (AMD K6 Duron
    1.2 GHz, 512 MB, 7,200 HDD) that is happy doing all of the
    following at the same time
      * compiling a kernel
      * streaming local MP3s to three other computers
      * being used intensely through X (it's my main computer).
    In fact, to verify this, I told the system to also check and
    update tripwire while I was additionally running the slocate
    updater. Other than the interactive use, these activities are
    very tough on the disk, and yet I see no 'D' processes.

In any case, loading up mutt on a Maildir folder of 1,000 messages
should not take seven Minutes. If it does, there must be heavy usage
of the disk from another source. If top doesn't show anything, what
other tool could I use to see what processes are accessing the
harddrive? Is there something like a disk monitor for Linux, which
registers every request to the HDD like there is for Windoze
(http://www.sysinternals.com/ntw2k/freeware/diskmon.shtml)?

> > My laptop, which is running Debian testing/unstable is not showing
> > this behaviour, and its load goes far higher at times. I also run
> > various other servers, partially on P5-120 systems, vanilla 2.4.xx
> > kernels and Debian testing, and there are no such problems there.
>=20
> sendmail tuning ?

postfix... but no. All my machines have identical postfix
configurations, and, as mentioned above, the problem is not only
triggered when postfix is active...

Thank you for your time!

[please continue to CC me]

--=20
 .''`.     martin f. krafft <madduck@debian.org>
: :'  :    proud Debian developer, admin, and user
`. `'`
  `-  Debian - when you have better things to do than fixing a system
=20
NOTE: The pgp.net keyservers and their mirrors are broken!
Get my key here: http://people.debian.org/~madduck/gpg/330c4a75.asc

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Ag6/IgvIgzMMSnURAkXNAKCsjSz45quetqQYI6Y7bUpW9gCWYQCfT5Rw
/lh4a3Tgv3MHSgY9RwrAvEw=
=qwYP
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
