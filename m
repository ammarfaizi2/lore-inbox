Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266804AbTBGWsw>; Fri, 7 Feb 2003 17:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTBGWsw>; Fri, 7 Feb 2003 17:48:52 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:11023 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S266804AbTBGWsv>; Fri, 7 Feb 2003 17:48:51 -0500
Date: Fri, 7 Feb 2003 23:58:17 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>, jt@hpl.hp.com,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: two x86_64 fixes for 2.4.21-pre3
Message-ID: <20030207225816.GD1879@arthur.ubicom.tudelft.nl>
References: <20030124193721.GA24876@wotan.suse.de> <15926.60767.451098.218188@harpo.it.uu.se> <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se> <20030129162824.GA4773@wotan.suse.de> <15934.49235.619101.789799@harpo.it.uu.se> <20030203194923.GA27997@bougret.hpl.hp.com> <20030203201255.GA32689@wotan.suse.de> <20030207105818.GB750@elf.ucw.cz> <1044628339.14350.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <1044628339.14350.5.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2003 at 02:32:20PM +0000, Alan Cox wrote:
> -ENOSYS is the normal return for an unknown syscall. -ENOTTY for an
> invalid ioctl (-EINVAL I think is wrong ?)

About a year ago -ENOTTY was explained like this:

  IOW, "not a tty" used to mean "WTF are you using ioctls here?"

          - Al Viro explaining ENOTTY on linux-kernel

(Hey, the kernelnewbies.org fortunes file is useful, right? ;)


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+RDoI/PlVHJtIto0RAveyAJ4/6YCL8xRRxZkiRRV3He+6539USwCcCya8
nwl3wkahFJIvgC+SjcadHWI=
=zUMV
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
