Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161358AbWJKTbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161358AbWJKTbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161365AbWJKTbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:31:46 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:41172 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1161358AbWJKTbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:31:45 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC] Avoid PIT SMP lockups
Date: Wed, 11 Oct 2006 22:31:49 +0300
User-Agent: KMail/1.9.5
Cc: kraxel@suse.de, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
References: <1160170736.6140.31.camel@localhost.localdomain> <200610112209.23037.caglar@pardus.org.tr> <1160594802.5973.7.camel@localhost.localdomain>
In-Reply-To: <1160594802.5973.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7639364.oIUNP0HhNz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610112231.49942.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7639364.oIUNP0HhNz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

11 Eki 2006 =C3=87ar 22:26 tarihinde, john stultz =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> On Wed, 2006-10-11 at 22:09 +0300, S.=C3=87a=C4=9Flar Onur wrote:
> > 11 Eki 2006 =C3=87ar 21:43 tarihinde, john stultz =C5=9Funlar=C4=B1 yaz=
m=C4=B1=C5=9Ft=C4=B1:
> > > S.=C3=87a=C4=9Flar: Didn't follow this bit at all. Could you explain =
a bit more?
> >
> > Of course, while system boots kernel waits ~5 seconds (maybe more) after
> > printing "Checking if this processor honours the WP bit even in
> > supervisor mode... Ok." line without any visual activity and after that
> > waiting period kernel panics.
>
> And this results in the same panic you linked to earlier?

Yes, kernel only panics if it waits there, if somehow can pass here (as i=20
wrote before it can boot normally for every ~1/10 reboot) no panic occurs.

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart7639364.oIUNP0HhNz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFLUaly7E6i0LKo6YRAuPUAJ0fcm+wbQBoLm/JdoNvHyEZLl1ZGwCdHtBq
kOEm/hFcs5Tq1nnoc6is0mc=
=2gy7
-----END PGP SIGNATURE-----

--nextPart7639364.oIUNP0HhNz--
