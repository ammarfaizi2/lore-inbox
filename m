Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131566AbRCUQMn>; Wed, 21 Mar 2001 11:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131567AbRCUQMd>; Wed, 21 Mar 2001 11:12:33 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:35129 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131566AbRCUQMZ>; Wed, 21 Mar 2001 11:12:25 -0500
Date: Wed, 21 Mar 2001 16:59:48 +0100
From: Kurt Garloff <garloff@suse.de>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Message-ID: <20010321165948.I3514@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Mike Galbraith <mikeg@wen-online.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <vba1yrr7w9v.fsf@mozart.stat.wisc.edu> <Pine.LNX.4.33.0103210733470.929-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103210733470.929-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Wed, Mar 21, 2001 at 07:41:55AM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2001 at 07:41:55AM +0100, Mike Galbraith wrote:
> On 20 Mar 2001, Kevin Buhr wrote:
> >     real    60m4.574s
> >     user    101m18.260s  <-- impossible no?
> >     sys     3m23.520s
>=20
> Why do numbers like this show up?  I noticed some of this after having
> enabled SMP on my UP box.

As you have two CPUs, you can spend more time in CPU than your wall clock
shows if you time multithreaded processes or multiple processes. At most
(ideal case) twice as much.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6uM/zxmLh6hyYd04RAkWQAJ9e83kaHulgP3QIXkYEdehbL71GMgCgnLBV
NupPvRlsSI8nlTOhSWGknzc=
=aETW
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
