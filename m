Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbUCXKOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 05:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbUCXKOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 05:14:40 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:5248 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S263192AbUCXKOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 05:14:36 -0500
Date: Wed, 24 Mar 2004 11:14:31 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
Message-Id: <20040324111431.49071a9f@phoebee>
In-Reply-To: <20040324020538.654905ee.akpm@osdl.org>
References: <20040323232511.1346842a.akpm@osdl.org>
	<20040324110014.4cdb7597@phoebee>
	<20040324020538.654905ee.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.10claws27 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__24_Mar_2004_11_14_31_+0100_LffQcSpP2pQd/AEM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__24_Mar_2004_11_14_31_+0100_LffQcSpP2pQd/AEM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 24 Mar 2004 02:05:38 -0800
Andrew Morton <akpm@osdl.org> bubbled:

> Martin Zwickel <martin.zwickel@technotrend.de> wrote:
> >
> > Hi Andrew!
> > 
> > I'm unable to start my X server with this patch.
> > I have the nvidia 5336 module loaded and if I start the X server, the
> > machine completely freezes. With 2.6.5-rc2 everything works ok...
> 
> -mm kernels currently are using 4k kernel stacks.  The nvidia driver
> doesn't have a hope of running in that environment.

Oh, thought it's a config option and 8k is set as default.
Thx for the answer! So back to 2.6.5-rc2 :( I like your mm patches so much since
they improve performance most times for my needs.

Regards,
Martin

-- 
MyExcuse:
Electrons on a bender

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Wed__24_Mar_2004_11_14_31_+0100_LffQcSpP2pQd/AEM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYV+JmjLYGS7fcG0RAljdAJ9cUUxTnW4jqpq9iwoMhLiDz24LagCfUpxy
WL68jHDqk9bNz0qnnwcLlIg=
=aN0H
-----END PGP SIGNATURE-----

--Signature=_Wed__24_Mar_2004_11_14_31_+0100_LffQcSpP2pQd/AEM--
