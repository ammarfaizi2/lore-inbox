Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272320AbRHXUcX>; Fri, 24 Aug 2001 16:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272319AbRHXUcP>; Fri, 24 Aug 2001 16:32:15 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:14690 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S272320AbRHXUcD>; Fri, 24 Aug 2001 16:32:03 -0400
Date: Fri, 24 Aug 2001 22:32:18 +0200
From: Kurt Garloff <garloff@suse.de>
To: Hua Zhong <hzhong@cisco.com>
Cc: ddade@digitalstatecraft.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Is it bad to have lots of sleeping tasks?
Message-ID: <20010824223218.N8355@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Hua Zhong <hzhong@cisco.com>, ddade@digitalstatecraft.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E15aNCX-0006PH-00@the-village.bc.nu> <005a01c12cd9$2f153950$103147ab@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/Q3JWIUAuLE0ZFy"
Content-Disposition: inline
In-Reply-To: <005a01c12cd9$2f153950$103147ab@cisco.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2001 at 01:13:04PM -0700, Hua Zhong wrote:
> > Linus scheduler is pretty dire beyond about 8 runnable threads, but very
> > good below that. It also has a refresh loop that is O(n) tasks, which is
> > strange, and actually looks easily to eliminate.
>=20
> So why not do it?  Or implement a nicer scheduler?  There are many good
> ones.  There are o(1) schedulers that provide much better proportional
> sharing.  They scale and also perform well even in "few running processes"
> case.  They are also not hard to implement (I once implemented such a
> scheduler with 100 lines of patch, and that fitted in the existing Linux
> runqueue framework).  What's the resistence to scheduler changes?

Expect Larry to jump on you.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7hrnRxmLh6hyYd04RAnI4AJ4/IG/XyfwEJq3IJO/GELr3KVYhCwCdEPp7
tWNAlUafgXbP63IU+zGshZo=
=BAF5
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--
