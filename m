Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131076AbRCWOvT>; Fri, 23 Mar 2001 09:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRCWOvJ>; Fri, 23 Mar 2001 09:51:09 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:37952 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131076AbRCWOvA>; Fri, 23 Mar 2001 09:51:00 -0500
Date: Fri, 23 Mar 2001 15:47:52 +0100
From: Kurt Garloff <garloff@suse.de>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] blocking w/ spinlock or interrupt's disabled
Message-ID: <20010323154752.H12408@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Dawson Engler <engler@csl.Stanford.EDU>,
	linux-kernel@vger.kernel.org, mc@cs.stanford.edu
In-Reply-To: <200103180423.UAA17766@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103180423.UAA17766@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Sat, Mar 17, 2001 at 08:23:34PM -0800
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TKDEsImF70pdVIl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dawson,

On Sat, Mar 17, 2001 at 08:23:34PM -0800, Dawson Engler wrote:
> > enclosed are 163 potential bugs in 2.4.1 where blocking functions are
> > called with either interrupts disabled or a spin lock held.  The
> > checker works by:=20
>=20
> Here's the file manifest.  Apologies.
>=20
[...]
> drivers/scsi/tmscsim.c
[...]

I'm interested in this one as I'm the maintainer ...

How do I get more details on the problem?

Most other CHECKER reports have been indicating the function where the
problem occurs, this unfortunately not. Am I missing something?

PS: Very nice work! Keep on going!

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6u2IXxmLh6hyYd04RAhVTAKCYdYHdYDYWfjl0TWPAP/FwVjgNgQCgiVeD
RgiHW/AHTen7ahIl7QWjs+Q=
=17GN
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--
