Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbUDAOMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 09:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbUDAOMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 09:12:42 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:7570 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S262917AbUDAOMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 09:12:40 -0500
Date: Thu, 1 Apr 2004 16:12:28 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-Id: <20040401161228.48b9c7a9@phoebee>
In-Reply-To: <20040401135920.GF18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random>
X-Mailer: Sylpheed version 0.9.10claws36 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__1_Apr_2004_16_12_28_+0200_nNEt4msAtE7/4xt0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__1_Apr_2004_16_12_28_+0200_nNEt4msAtE7/4xt0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 1 Apr 2004 15:59:20 +0200
Andrea Arcangeli <andrea@suse.de> bubbled:

> Oracle needs this sysctl, I designed it and Ken Chen implemented it. I
> guess google also won't dislike it.
> 
> This is a lot simpler than the mlock rlimit and this is people really
> need (not the rlimit). The rlimit thing can still be applied on top of
> this. This should be more efficient too (besides its simplicity).
> 
> can you apply to mainline?
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.5-rc3-aa1/disable-cap-mlock-1

this is the correct link:
http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.5-rc3/disable-cap-mlock-1

-- 
MyExcuse:
Processes running slowly due to weak power supply

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Thu__1_Apr_2004_16_12_28_+0200_nNEt4msAtE7/4xt0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAbCNMmjLYGS7fcG0RAoPMAJ9+XGrvH53M4uZMQ2M1Kn57eS6EHACdFpPz
HdlwQnvNRIqynmzZbNXKhm0=
=qTyS
-----END PGP SIGNATURE-----

--Signature=_Thu__1_Apr_2004_16_12_28_+0200_nNEt4msAtE7/4xt0--
