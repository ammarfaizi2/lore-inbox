Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWDOSXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWDOSXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 14:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWDOSXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 14:23:55 -0400
Received: from server021.webpack.hosteurope.de ([80.237.130.29]:184 "EHLO
	server021.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1030302AbWDOSXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 14:23:54 -0400
From: Michael Gerdau <mgd@technosis.de>
Reply-To: mgd@technosis.de
Organization: Technosis GmbH
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: [patch][rfc] quell interactive feeding frenzy
Date: Sat, 15 Apr 2006 20:23:21 +0200
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, Al Boldi <a1426z@gawab.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
References: <200604112100.28725.kernel@kolivas.org> <200604140616.33370.a1426z@gawab.com> <200604151705.18786.kernel@kolivas.org>
In-Reply-To: <200604151705.18786.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1377294.BFAcsrkest";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604152023.49052.mgd@technosis.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1377294.BFAcsrkest
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Thanks for bringing this to my attention. A while back I had different=20
> management of forked tasks and merged it with PF_NONSLEEP. Since then I'v=
e=20
> changed the management of NONSLEEP tasks and didn't realise it had advers=
ely=20
> affected the accounting of forking tasks. This patch should rectify it.

[snip]

At least here this patch solves the "previously working" (i.e. starving)
testcase, i.e. now all eatm-processes continue to work.

Best,
Michael
=2D-=20
 Vote against SPAM - see http://www.politik-digital.de/spam/
 Michael Gerdau       email: mgd@technosis.de
 GPG-keys available on request or at public keyserver

--nextPart1377294.BFAcsrkest
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBEQTo0UYYhyuxDQc4RAvfsAJ0aHldp/Iz7CgVZftoYem9WThZ8VgCffi8p
T6gE8VwnjLB8O17jMdce9W8=
=LWvS
-----END PGP SIGNATURE-----

--nextPart1377294.BFAcsrkest--
