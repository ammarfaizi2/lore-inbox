Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313163AbSC1O2a>; Thu, 28 Mar 2002 09:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313164AbSC1O2U>; Thu, 28 Mar 2002 09:28:20 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:65364 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S313163AbSC1O2H>; Thu, 28 Mar 2002 09:28:07 -0500
Date: Thu, 28 Mar 2002 15:28:05 +0100
From: Kurt Garloff <garloff@suse.de>
To: Rob Landley <landley@trommello.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ssh won't work from initial ram disk in 2.4.18
Message-ID: <20020328152805.D31485@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Rob Landley <landley@trommello.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020328124257.99FD54FF@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2002 at 07:28:05AM -0500, Rob Landley wrote:
> I'm using a 2.4.18 kernel and ssh 3.0.2, and I'm trying to run ssh from t=
he=20
> initrd, and it's refusing to work.  The exact same setup works booted fro=
m a=20
> small partition, but if I take a tarball of that filesystem and dump it i=
nto=20
> a ramdisk, ssh always fails to authenticate.  (Public key or password, it=
=20
> doesn't matter.  When I run it from sh in initrd, it doesn't even prompt =
me=20
> for a password, just prints out three failure messages and exits.  The sa=
me=20
> setup from /dev/hda1 works just fine...)

ssh tries to talk to your console.
Which apparently has not yet been assigned / set up.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8oyh1xmLh6hyYd04RAl7vAKC5IwZC9nPkifWY7SKjE+DeFM8XAQCfekE4
F5KvFgYfAkbkwmyrbawkm8M=
=iQpd
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
