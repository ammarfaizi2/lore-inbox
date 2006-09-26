Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWIZVP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWIZVP7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWIZVP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:15:59 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:16542 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932415AbWIZVP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:15:58 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Greg Schafer <gschafer@zip.com.au>
Subject: Re: 2.6.18 Nasty Lockup
Date: Wed, 27 Sep 2006 00:15:47 +0300
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
References: <20060926123640.GA7826@tigers.local>
In-Reply-To: <20060926123640.GA7826@tigers.local>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart144916769.ABVx43XsBX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609270015.51465.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart144916769.ABVx43XsBX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

26 Eyl 2006 Sal 15:36 tarihinde, Greg Schafer =C5=9Funlar=C4=B1 yazm=C4=B1=
=C5=9Ft=C4=B1:=20
> This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> completely dead machine with only option the reset button. Usually happens
> within a couple of minutes of desktop use but is 100% reproducible. Probl=
em
> is still there in a fresh checkout of current Linus git tree (post 2.6.18=
).

Same symptoms here and its reproducible after starting the irqbalance (0.12=
 or=20
0.13), if i disable irqbalance then everything is going fine.

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart144916769.ABVx43XsBX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFGZiHy7E6i0LKo6YRAmzXAKCIqKRGZCHyiVSSpmcEQlod/QsbIACfZ9jQ
rXy9ptfiN9i4H30rqNd/990=
=knfJ
-----END PGP SIGNATURE-----

--nextPart144916769.ABVx43XsBX--
