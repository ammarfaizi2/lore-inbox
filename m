Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSDLPLh>; Fri, 12 Apr 2002 11:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314102AbSDLPLg>; Fri, 12 Apr 2002 11:11:36 -0400
Received: from kirk.etnet.fr ([195.146.194.12]:33810 "EHLO kirk.etnet.fr")
	by vger.kernel.org with ESMTP id <S314101AbSDLPLf>;
	Fri, 12 Apr 2002 11:11:35 -0400
Date: Fri, 12 Apr 2002 17:12:06 +0200
From: Guillaume Gimenez <ggimenez@prologue-software.fr>
To: <linux-kernel@vger.kernel.org>
Cc: Rowan Ingvar Wilson <rowan.ingvar.wilson@0800dial.com>,
        "blesson paul" <blessonpaul@msn.com>, Samuel Maftoul <maftoul@esrf.fr>
Subject: Re: /dev/zero
Message-Id: <20020412171206.2783acce.ggimenez@prologue-software.fr>
In-Reply-To: <20020412100804.A6605@pcmaftoul.esrf.fr>
Organization: Prologue Software
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #aYAM@CUO[tWCSX=wrnq$Aou=9$*@-<8{sgt[sSL;U(&AIRAJpcVt`0`=<gW@j?B5~[$uVf j6<bh?MB`;Ug#@.HxckUG)/`~dT(,3~\&q{QQX<*yu,p,XGfU+-~OO^w@?FC;Yv+uUq']Y&?P)?G:n cP^h4o=/N)gGrj}o\dB8}&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=..s_CYQ8_0G1FSr"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=..s_CYQ8_0G1FSr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Samuel Maftoul a écrit:
    Samuel> It's just zeroes, so it allows you to test raw write speed on any
    Samuel> device:
    Samuel> dd if=/dev/zero of=/dev/hda to test your performances of hda ...
    Samuel> normally if I get it well, /dev/zero can't be you're bottleneck.
    Samuel>         Sam

Just to save Samuel's soul ;-)
the dd command supplied above will erase your primary hard drive

To see hard drive performances, hdparm -tT /dev/hda is better.

PS: Pas sympa Samuel

-- 
Guillaume Gimenez

--=..s_CYQ8_0G1FSr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6b (GNU/Linux)

iD8DBQE8tvlJ00PDGGWQcLIRAqyFAKCwYQWQjFx90he4zfg7czjsaQ0STQCgmhM6
Hkwb0lzvicgLyZDYiY5yMjE=
=sDib
-----END PGP SIGNATURE-----

--=..s_CYQ8_0G1FSr--

