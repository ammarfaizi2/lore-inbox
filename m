Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271262AbUJVMTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271262AbUJVMTz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271256AbUJVMTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:19:03 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:48574 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S271251AbUJVMS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:18:57 -0400
Date: Fri, 22 Oct 2004 14:18:56 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.x: nfs warning: mount version older than kernel
Message-ID: <20041022141856.50d2b1a6@phoebee>
In-Reply-To: <Pine.LNX.4.61.0410220727120.514@p500>
References: <Pine.LNX.4.61.0410220727120.514@p500>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__22_Oct_2004_14_18_56_+0200_JvHo1j.w6lYsbkuw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__22_Oct_2004_14_18_56_+0200_JvHo1j.w6lYsbkuw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 22 Oct 2004 07:29:46 -0400 (EDT)
Justin Piszcz <jpiszcz@lucidpixels.com> bubbled:

> # mount -a
> # dmesg | tail -n 5
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> # mount --version
> mount: mount-2.12h
> #
> 
> I am using the latest util-linux from the developers site, so I am 
> curious, why do I get this warning in dmesg/ring-buffer?
> 
> # ftp://ftp.win.tue.nl/pub/linux-local/utils/util-linux/
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I think it's about the nfs server/client versions, not the version
of mount.

-- 
MyExcuse:
We only support a 28000 bps connection.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Fri__22_Oct_2004_14_18_56_+0200_JvHo1j.w6lYsbkuw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBePqwmjLYGS7fcG0RAub3AJ4l/YljL25U5blhEs8Gy9DFFF2dhgCdEtgH
B6Vy0NjDtWTqUKOllDFgEUE=
=Rsbx
-----END PGP SIGNATURE-----

--Signature=_Fri__22_Oct_2004_14_18_56_+0200_JvHo1j.w6lYsbkuw--
