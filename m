Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTIBVHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTIBVHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:07:30 -0400
Received: from ns.suse.de ([195.135.220.2]:53177 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264500AbTIBVH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:07:27 -0400
Date: Tue, 2 Sep 2003 23:07:23 +0200
From: Kurt Garloff <garloff@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22aa1
Message-ID: <20030902210723.GB9499@nbkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20030902020218.GB1599@dualathlon.random> <200309022037.39364.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <200309022037.39364.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.4.21-6-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SuSE(DE), TU/e(NL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2003 at 08:38:39PM +0200, Marc-Christian Petersen wrote:
> Hi Andrea,
>=20
> > Only in 2.4.22aa1: 20_sched-o1-fixes-10
> > Only in 2.4.22pre7aa1: 20_sched-o1-fixes-9
> > 	Changed the CHILD_PENALTY logic to be centered around
> > 	50%. From Kurt Garloff.
>=20
> the changes 's/CHILD_PENALTY/CHILD_INHERITANCE' and "s/PARENT_PENALTIY//'=
 are=20
> really awfull for desktops.=20

Please work out. What's your settings?

> If I change child_inheritance from 60 to 95 and=20
> reintroduce the logic with parent_penaltiy, it's alot smooter under load.

Hmm, you can set CHILD_INHERITANCE to 90 to have a comparable value
compared to CHILD_PENALTY of 95.=20
What do you do with PARENT_PENALTY? It's at 100 and thus a noop
normally.

> I think these logics should be #ifdef'ed with CONFIG_DESKTOP, no?

No.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
GPG key: See mail header, key servers                 SuSE Labs (Head)
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/VQaLxmLh6hyYd04RAvgVAKDMQo1Jf556/k1BSb2ZUzT9xkYPcQCgglqw
QDNcddo+oUcMAudmxKooh8w=
=O0sS
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
