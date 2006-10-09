Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932910AbWJIQXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbWJIQXa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932962AbWJIQXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:23:30 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:34515 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S932910AbWJIQX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:23:29 -0400
From: Mike Frysinger <vapier@gentoo.org>
Organization: wh0rd.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [patch] pull in linux/types.h in linux/nbd.h
Date: Mon, 9 Oct 2006 12:23:27 -0400
User-Agent: KMail/1.9.4
Cc: Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org
References: <200610082012.27879.vapier@gentoo.org> <Pine.LNX.4.61.0610090912030.12485@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610090912030.12485@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2113852.RNY8uFpfUq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610091223.28070.vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2113852.RNY8uFpfUq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 09 October 2006 03:12, Jan Engelhardt wrote:
> >the nbd header uses __be32 and such types but doesnt actually include the
> >header that defines these things (linux/types.h); so lets include it
>
> Hm, <linux/cdev.h> uses struct kobject and should therefore include
> <linux/kobejct.h>, can  you make a patch for that too? Thanks.

linux/cdev.h isnt exported to userspace so i dont really care about it ... =
if=20
you do, feel free to write the patch yourself. Thanks.
=2Dmike

--nextPart2113852.RNY8uFpfUq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARSp3f0FjO5/oN/WBAQJxNA//bpyehiE00jc+I25r9Ne6+o3uaJSItvcg
O4w+GRvW/ckoB2l4tzEcwotDV7HuqNA4UBYbKeYnnhcru6gBWi8kp1UnlbW1REFa
8DU/sHKdwdTkHIU8kSevHfgIHikcYoRQhN/bt6dkTfr5vAuvSn+78JDZqwcarVKb
FDXR/D5j2pzL5ssi+7B9w1e6g2QLF9qEy7gqedVcR5h+4YGFSI51OMJUdB07fagy
sVHDxRog4AS5zrUZeA8j+Xo6T7pRuH95j1ATVTLSOCqj68Y+Ir0QrdvyjqC7dEJe
amWmlFSCuGB08CHFEYYqXuUJphw4Paee9VOFtnGOdznooRo/5igAXz9hVmCZw+P4
kk6WCHCJ6eHwqtirPpj4XqQE1Zj54rwEByXvSJpKIJ3dd/bgjHBebSkFLv3TWJgq
CzY2YtwbzphiEylIb1c7OiqcuMm5if7yIc2jZCeMKWrOtf/7jiQcoFic9a/VMr/V
sSV5D71BfoQ9WcVqDWwLuwKBc1n5IFWe4C+w0+YshU7KiFNd119CPmDQLcdt0tQ7
WghLiFsRI9OHenACSCyrj9T/Yh7Zd7TFGCUKVfDLPMGgN+Ot631bgPon3uLlnVx+
5wfGIPlgw2m73ENWWmYo0V5yGJ90HUpEGjQup7rVmetwM075aVu0lExy7qtLiyPf
BoyZPLBz7Pw=
=9pyi
-----END PGP SIGNATURE-----

--nextPart2113852.RNY8uFpfUq--
