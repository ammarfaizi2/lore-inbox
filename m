Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbUBZIZc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 03:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbUBZIZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 03:25:32 -0500
Received: from [213.69.232.58] ([213.69.232.58]:28426 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S262735AbUBZIZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 03:25:17 -0500
Date: Thu, 26 Feb 2004 09:25:51 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: another hard disk broken or xfs problems?
Message-ID: <20040226082551.GA218@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Nathan Scott <nathans@sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040225220051.GA187@schottelius.org> <20040225223428.GD640@frodo> <20040225234944.GD187@schottelius.org> <20040226032741.GB1177@frodo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20040226032741.GB1177@frodo>
X-MSMail-Priority: (u_int) -1
X-Mailer: echo $message | gpg -e $sender  -s | netcat mailhost 25
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nathan Scott [Thu, Feb 26, 2004 at 02:27:41PM +1100]:
> On Thu, Feb 26, 2004 at 12:49:44AM +0100, Nico Schottelius wrote:
> > Nathan Scott [Thu, Feb 26, 2004 at 09:34:28AM +1100]:
> > > [...]=20
> > > So, doesn't look like a hard disk error to me, and nor does it
> > > look like an XFS problem.  You should be able to run xfs_repair
> > > on your loopback file to fix the problem.
> >=20
> > Will reboot in half an hour, but I think as the recovery was done, it
> > won't have any problems anymore.
>=20
> Well, recovery is a garbage-in, garbage-out process - I
> think you will need to repair that loopback file.

Well, after the recovery the system works fine again.

> > There are still some questions open for me:
> >=20
> > 1. why is it an internal xfs error?
>=20
> Your loopback file seems to have got corrupted, XFS reports
> this as an internal error (generic error message).

I am really wondering about the error message, as "internal errors"=20
indicate for me an error in the kernel.

> > 2. why does it print a call trace?
>=20
> XFS detected corruption, and tried to dump out some state info
> at the point where it noticed the problem.

I am wondering how my dmesg will look like if I've to recover some
Gigabytes of date.

And btw, do all filesystem drivers behave in this way, printing internal
errors and displaying call traces when they find errors in the
filesystem?

For me this is really confusing.

Sincerly,

Nico

--=20
Keep it simple & stupid, use what's available.
pgp: 8D0E E27A          | Nico Schottelius
http://nerd-hosting.net | http://linux.schottelius.org

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPa2PzGnTqo0OJ6QRAiP+AKCpexhlRQdKA9fBl6uA3IZE5RQCRQCdGdks
hy6+TlprfPqRVm5Wn4hMk2c=
=rNSS
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
