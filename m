Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276157AbRI1Qmi>; Fri, 28 Sep 2001 12:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276156AbRI1Qm3>; Fri, 28 Sep 2001 12:42:29 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:12832 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S276157AbRI1QmU>; Fri, 28 Sep 2001 12:42:20 -0400
Date: Fri, 28 Sep 2001 18:42:46 +0200
From: Kurt Garloff <garloff@suse.de>
To: tip@prs.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: 2.4.10 lockup using ppp on SMP
Message-ID: <20010928184246.M1731@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>, tip@prs.de,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3BB4912A.414B809A@internetwork-ag.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/jvaajy/zP2g41+Q"
Content-Disposition: inline
In-Reply-To: <3BB4912A.414B809A@internetwork-ag.de>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.10 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/jvaajy/zP2g41+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2001 at 05:03:06PM +0200, Till Immanuel Patzschke wrote:
> Hi,
>=20
> 2.4.10 (and all its 2.4.x predecessors) lock up in ppp_destroy_interface.=
 Thanks
> to the kdb I got the two tracebacks below - the all_ppp_lock interferes w=
ith
> some other (socket?!) lock...
> Any help is VERY much appreciated!

Please try the patch that Chris Mason sent to LKML a day ago.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--/jvaajy/zP2g41+Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7tKiGxmLh6hyYd04RAmkhAKCvhLmpuU2aYNjNALUgrcSSJV9FKgCgyNUa
YaxFfOr+hZicT22ornqa2Xw=
=A8gz
-----END PGP SIGNATURE-----

--/jvaajy/zP2g41+Q--
