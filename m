Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131810AbRBMPhF>; Tue, 13 Feb 2001 10:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131888AbRBMPg4>; Tue, 13 Feb 2001 10:36:56 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:14755 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S131774AbRBMPgp>; Tue, 13 Feb 2001 10:36:45 -0500
Date: Tue, 13 Feb 2001 10:36:32 -0500
From: Pete Toscano <pete@research.netsol.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x SMP blamed for Xfree 4.0 crashes
Message-ID: <20010213103632.R15595@tesla.admin.cto.netsol.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20010213130505.gale@syntax.dera.gov.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="soWJpSPh+l8Y6Fy7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010213130505.gale@syntax.dera.gov.uk>; from gale@syntax.dera.gov.uk on Tue, Feb 13, 2001 at 01:05:05PM -0000
X-Uptime: 10:31am  up 10 days, 19:43,  9 users,  load average: 0.09, 0.14, 0.09
X-Married: 457 days, 14 hours, 46 minutes, and 7 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--soWJpSPh+l8Y6Fy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i have been running 4.0.2 on my smp system using the 2.4.1 kernel.  the
one thing is, i was using the xfree out of precision insite's cvs with
the g400 binary-only hal lib dri module loaded.  every-so-often,
especially when closing windows or switching virtual desktops, the
kernel would crash.  luckily, i'm also running kdb on a serial console,
so i am able to check things out and keep a log.  unfortunately, when
btp all the processes, i found no text.lock, which is as far as i know
how to "debug" a kernel crash.

of course, this could very well be something wrong with the binary-only
module from matrox, so i'm seeing if the same problem presents itself
with the original mga.o loaded (which also disables hardware dri).

pete

On Tue, 13 Feb 2001, Tony Gale wrote:

> Having experienced a number of crashes with Xfree 4.0 with 2.4
> kernels, that I wasn't getting with 2.2 kernels, a quick search on
> the xfree Xpert mailing list reveals this:

--=20
Pete Toscano         pete@research.netsol.com          703.948.3364
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--soWJpSPh+l8Y6Fy7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6iVSAH/Abp5AIJzYRAmMGAJ4z6QwXfQs8mLf28w0RScY3XRFAdQCfbiyn
k71Ws1SlgEt+fRxKnYb1RR8=
=al26
-----END PGP SIGNATURE-----

--soWJpSPh+l8Y6Fy7--
