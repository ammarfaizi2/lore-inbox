Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271308AbTHCWVO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 18:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271295AbTHCWVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 18:21:13 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:4811
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S271286AbTHCWVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 18:21:08 -0400
Date: Sun, 3 Aug 2003 18:23:13 -0400
From: Diffie <diffie@blazebox.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030803222313.GA1090@blazebox.homeip.net>
References: <20030801182207.GA3759@blazebox.homeip.net> <20030801144455.450d8e52.akpm@osdl.org> <20030803015510.GB4696@blazebox.homeip.net> <20030802190737.3c41d4d8.akpm@osdl.org> <20030803214755.GA1010@blazebox.homeip.net> <20030803145211.29eb5e7c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20030803145211.29eb5e7c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Slackware Linux 9.0
X-Kernel-Version: Linux 2.4.21-xfs
X-Mailer: Mutt 1.4.1i http://www.mutt.org
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.20.0.1; VDF: 6.20.0.55; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 03, 2003 at 02:52:11PM -0700, Andrew Morton wrote:
> Diffie <diffie@blazebox.homeip.net> wrote:
> >
> > I think this bug is due to me using the aic7xxx_old code ver 5.x.x.
> >=20
> >  Under kernel 2.4.21 the aic7xxx (new) is ver 6.2.8 and it works great
> >  with Adaptec AHA-2940U2W controller i have.
> >=20
> >  On 2.6.0-test2-mm3 (tried Linus test1,test2,mm1 and mm2) the NEW aic7x=
xx
> >  uses ver 6.2.35 and will not scan my IBM drive even though it
> >  initializes the correct SCSI ID,LUN etc...
> >=20
> >  I would like to contact and report this issue to the aic7xxx maintaner
> >  and perhaps get it resolved.Where would be the best place to report th=
is
> >  kind of problem?
> >=20
> >  I have taken few screen captures which are available at:
> >  http://www.blazebox.homeip.net:81/diffie/images/2.6.0-test2/ and show
> >  the aic7xxx (new) failure.
>=20
> An appropriate way to report this would be to email Justin (CC'ed here)
> and linux-scsi@vger.kernel.org.
>=20
>=20

Andrew,

Thank you for all your help.Sorry but i gave the wrong URL in previous
email.The correct one is http://www.blazebox.homeip.net:81/diffie/images/li=
nux-2.6.0-test2/=20

Attached is the dmesg,lspci and aic7xxx /proc information from 2.4.21
kernel.

Regards,

Paul B.


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LYtRIymMQsXoRDARAtdQAJ9BoO9pC9UCoC2CzYR7s3+oN4v7nACfcQOP
UhleCBFL4ZvqAPqfHrQfgdc=
=Hkce
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
