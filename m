Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbVJESCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbVJESCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 14:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVJESCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 14:02:09 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:63183 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S1030304AbVJESCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 14:02:08 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm - swap prefetch v14
Date: Wed, 5 Oct 2005 20:01:51 +0200
User-Agent: KMail/1.7.2
References: <200510052257.15713.kernel@kolivas.org>
In-Reply-To: <200510052257.15713.kernel@kolivas.org>
Cc: Con Kolivas <kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1738669.CmxCxXHZ4R";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510052002.04173.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1738669.CmxCxXHZ4R
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Con,

your patch still contains a serious BUG :-)

On Wednesday 05 October 2005 14:57, Con Kolivas wrote:
> -The tunable to determine the amount of data retrieved per prefetch was a=
dded
> /proc/sys/vm/swap_prefetch=20
> is used to decide how many groups of 128kb to prefetch per 1 second inter=
val=20
> and is set to 2 by default. It can be disabled by setting it to 0

swap_prefetch is not documented at Documentation/sysctl/vm.txt

This simple text would suffice I think. Maybe comment about disabling it
for laptop usage.


Regards

Ingo Oeser


--nextPart1738669.CmxCxXHZ4R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDRBUcU56oYWuOrkARAjRQAJ4zkSKLMrelNSJIZc6UW0BCwVTI1ACg3lyV
UQI7KDxT1zSBar2tNUIU6zk=
=aqUh
-----END PGP SIGNATURE-----

--nextPart1738669.CmxCxXHZ4R--
