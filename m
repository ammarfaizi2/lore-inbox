Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVHLTPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVHLTPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVHLTPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:15:34 -0400
Received: from lugor.de ([212.112.242.222]:38540 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1751249AbVHLTPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:15:33 -0400
From: Christian Hesse <mail@earthworm.de>
To: ncunningham@cyclades.com
Subject: Re: Hang at resume with AC adapter not plugged
Date: Fri, 12 Aug 2005 21:14:46 +0200
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net, spock@gentoo.org
References: <200508090741.29149.mail@earthworm.de> <1123566339.4370.131.camel@localhost>
In-Reply-To: <1123566339.4370.131.camel@localhost>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)k
	:nv*xqk4C@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)n#Q.o
	kE~&T]0cQX6]<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<3O7GY9y_i!qG&Vv\D8/
	%4@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart374635956.CnBFtMB5xv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508122115.00197.mail@earthworm.de>
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart374635956.CnBFtMB5xv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 09 August 2005 07:45, Nigel Cunningham wrote:
> Hi Christian.
>
> On Tue, 2005-08-09 at 15:41, Christian Hesse wrote:
> > Hi everybody,
> >
> > I have a little problem with software suspend 2.1.9.1[012] on
> > 2.6.13-rc[3456]. The system hangs on resume if the AC adapter is not
> > plugged in. Everything works well if I use 2.1.9.5 on 2.6.12.x or plug =
in
> > the AC adapter. I've tried acpi-20050729 for 2.6.13-rc6 but that did not
> > change anything. The system is a Sumsung X10.
> >
> > Any ideas what could be the problem?
>
> Do you have the ACPI modules compiled in, or built as modules? I'd
> suggest that you try building them as modules and unloading while
> suspending if you're not doing that already.

Sometimes (very seldom) it also hangs if the AC adapter is plugged in, so I=
=20
tested some more and found another interesting fact: It boots just fine if =
I=20
use splash=3Dverbose insted of splash=3Dsilent (even without AC adapter). I=
've=20
patched the kernel with fbsplash-0.9.2-r4-2.6.13-rc[16].

Any idea what could be the cause?

=2D-=20
Christian

--nextPart374635956.CnBFtMB5xv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.18 (GNU/Linux)

iD8DBQBC/PU0lZfG2c8gdSURAi7nAKCoI2uGVw57FYi926OJJk5/IGmrNwCfdO58
lbXYMCXV+71yL0c/Dbf1nvU=
=X15X
-----END PGP SIGNATURE-----

--nextPart374635956.CnBFtMB5xv--
