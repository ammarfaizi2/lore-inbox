Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUFRTIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUFRTIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUFRTFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:05:52 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:15808 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S266743AbUFRTC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:02:59 -0400
Date: Fri, 18 Jun 2004 13:02:57 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: 4Front Technologies <dev@opensound.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618190257.GN14915@schnapps.adilger.int>
Mail-Followup-To: 4Front Technologies <dev@opensound.com>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de> <40D32C1D.80309@opensound.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Content-Disposition: inline
In-Reply-To: <40D32C1D.80309@opensound.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 18, 2004  10:53 -0700, 4Front Technologies wrote:
> The issue is also SuSE's 2.6.4 kernel added the REGPARM patch which was=
=20
> only introduced in Linux 2.6.5 for example. Wouldn't it be better if SuSE
> had shipped their kernel as Linux 2.6.5?. The point is what constitutes a
> "baseline" Linux kernel?. You can add all your patches but if now the
> kernel is more in tune with Linux 2.6.7, just call it Linux 2.6.7 - calli=
ng
> it 2.6.5 will break a lot of software that isn't included with your kerne=
l.

We gave up trying to use kernel versions to determine what features/interfa=
ce
to use for a given kernel long ago.  Instead we have configure check for a
particular interface and use "#ifdef HAVE_foo", not "#if LINUX_KERNEL_VERSI=
ON".

I can understand why SuSE does this - there is no way they can ship the
"latest" kernel and still have tested it thoroughly, yet if they find a
specific defect they need to fix it (preferrably in the same way that a
later kernel fixes it).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/                 http://members.shaw.ca/goli=
nux/


--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA0zxhpIg59Q01vtYRAmZnAJwLNdtGHUjLMRLKOdBO2+Uyz2YroACdG6w2
6CI8vAgDYzR+AQ8/YOapfL0=
=r0bd
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--
