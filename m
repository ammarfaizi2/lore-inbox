Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbULFP6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbULFP6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbULFP4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:56:25 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:57218 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261545AbULFPyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:54:51 -0500
Date: Mon, 6 Dec 2004 16:54:47 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: nVidea Graphics card not recognised by lspci
Message-ID: <20041206165447.7b61755c@phoebee>
In-Reply-To: <200412061040.50015.gene.heskett@verizon.net>
References: <kiiZIHd0T0000153f@hotmail.com>
	<20041206121608.585d7526@phoebee>
	<200412061429.05910.andrew@walrond.org>
	<200412061040.50015.gene.heskett@verizon.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__6_Dec_2004_16_54_47_+0100_JuHFgPuX0TOh/n3="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__6_Dec_2004_16_54_47_+0100_JuHFgPuX0TOh/n3=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 6 Dec 2004 10:40:49 -0500
Gene Heskett <gene.heskett@verizon.net> bubbled:

> On Monday 06 December 2004 09:29, Andrew Walrond wrote:
> 
> >update-pciids
> bash: update-pciids: command not found

as root?
it's in /sbin/update-pciids

> 
> System is FC2, kernel 2.6.10-rc3
> lspci version 2.1.99-test3
> 
> Do I need to grab a newer util package that contains lspci?
> 

# which update-pciids 
/sbin/update-pciids

# epm -qf `which update-pciids`
pciutils-2.1.11-r1


you can get the newest pci.ids file here:
http://pciids.sourceforge.net/pci.ids

-- 
MyExcuse:
Of course it doesn't work. We've performed a software upgrade.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Mon__6_Dec_2004_16_54_47_+0100_JuHFgPuX0TOh/n3=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBtIDJmjLYGS7fcG0RAkDvAKCqCUh0uyGTY1BhWMT5vva2UEHCUwCgsJYb
y8ltiHejIKmrqdFP1iNETwc=
=ZGbJ
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Dec_2004_16_54_47_+0100_JuHFgPuX0TOh/n3=--
