Return-Path: <linux-kernel-owner+w=401wt.eu-S936337AbWLIIov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936337AbWLIIov (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 03:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936396AbWLIIov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 03:44:51 -0500
Received: from psmtp13.wxs.nl ([195.121.247.25]:54276 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936337AbWLIIov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 03:44:51 -0500
Date: Sat, 09 Dec 2006 09:44:41 +0100
From: jos poortvliet <jos@mijnkamer.nl>
X-Face: $0>4o"Xx2u2q(Tx!D+6~yPc{ZhEfnQnu:/nthh%Kr%f$aiATk$xjx^X4admsd*)=?utf-8?q?IZz=3A=5FkT=0A=09=7CurITP!=2E?=)L`*)Vw@4\@6>#r;3xSPW`,~C9vb`W/s]}Gq]b!o_/+(lJ:b)=?utf-8?q?T0=26KCLMGvG=7CS=5E=0A=09z=7B=5C=2E7EtehxhFQE=27eYSsir/=7CtQ?=
 =?utf-8?q?j=23rWQe4o?=>WC>_R<vO,d]czmqWYkq[v~iB.e_GuxB'")
 =?utf-8?q?p3=0A=09jGdrhlY4=5E!vd=3F=3AegW?=)xn&fP4!FV<.
Subject: Re: [ck] 2.6.19-ck2
In-reply-to: <200612091614.30096.kernel@kolivas.org>
To: ck@vds.kolivas.org
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <200612090944.46358.jos@mijnkamer.nl>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=nextPart19110056.X3gvFUCPnT
Content-transfer-encoding: 7bit
User-Agent: KMail/1.9.5 + Features
References: <200612091614.30096.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart19110056.X3gvFUCPnT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op Sat Dec 9 2006, schreef Con Kolivas:
(cut)

> Changes (first significant changes since :
> Added:
> +sched-fix_iso_starvation.patch
> A bug first introduced into 2.6.18-ck1/cks1 meant that SCHED_ISO tasks we=
re
> not being throttled when above their cpu limit. This presents a security
> risk to any machine with user logins and upgrading for this issue should =
be
> considered a high priority.
>
>  +sched-make_softirqd_batch.patch
> Instead of 'nice'ing ksoftirqd we can use the policy hint of SCHED_BATCH
> which specifies it as not requiring low latency. This increases the cpu u=
se
> possible under very heavy softirq traffic (such as network loads) and
> decreases the latency that might otherwise be seen (such as keyboard input
> under heavy cpu load on slow machines).

nice, con, nice! good to see you're back! how are things progressing in the=
=20
japanese area?

grtz
Jos



=2D-=20
Disclaimer:

Alles wat ik doe denk en zeg is gebaseerd op het wereldbeeld wat ik nu heb.=
=20
Ik ben niet verantwoordelijk voor wijzigingen van de wereld, of het beeld w=
at=20
ik daarvan heb, noch voor de daaruit voortvloeiende gedragingen van mezelf.=
=20
Alles wat ik zeg is aardig bedoeld, tenzij expliciet vermeld.

--nextPart19110056.X3gvFUCPnT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFend++wgQ1AD35iwRAk8TAKDKMn11UK7LSZGuQQTnM+YPQmq4WQCgurU9
GhuGNEDY2SapALOsQYrHKyk=
=KUMT
-----END PGP SIGNATURE-----

--nextPart19110056.X3gvFUCPnT--
