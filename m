Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUGNMfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUGNMfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUGNMfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:35:45 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:54455 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S267372AbUGNMfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:35:43 -0400
Date: Wed, 14 Jul 2004 14:35:39 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Hlaing Oo <hlaing_1999@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing cdrom in new kernel 2.4.26
Message-Id: <20040714143539.33c186e8@phoebee>
In-Reply-To: <20040714121731.52870.qmail@web90005.mail.scd.yahoo.com>
References: <20040714121731.52870.qmail@web90005.mail.scd.yahoo.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__14_Jul_2004_14_35_39_+0200_zasIlccNX67BItb6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__14_Jul_2004_14_35_39_+0200_zasIlccNX67BItb6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 14 Jul 2004 05:17:31 -0700 (PDT)
Hlaing Oo <hlaing_1999@yahoo.com> bubbled:

> dear all 
> I am newbie of kernel rebuilder.
> I could rebuild 2.4.26 from 2.4.20-8.
> Almost everything okay, but cdrom.
> When I mount cdrom I got this message.
> 
> # mount -t iso9660 /dev/hdc /mnt/cdrom
> mount: /dev/hdc is not a valid block device

Are you using devfs? And devfs daemon?

have you tried:
# mount -t iso9660 /dev/ide/host0/bus1/target0/lun0/cd /mnt/cdrom
?

What major/minor does your /dev/hdc have?

Regards,
Martin

-- 
MyExcuse:
wrong polarity of neutron flow

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Wed__14_Jul_2004_14_35_39_+0200_zasIlccNX67BItb6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9SidmjLYGS7fcG0RAvXTAJ43b1Uo8PI7g4a+yQX4CbIF+7j8yQCdFXmd
QsdqOPhM3OmkI7UHhiw4mC0=
=oSer
-----END PGP SIGNATURE-----

--Signature=_Wed__14_Jul_2004_14_35_39_+0200_zasIlccNX67BItb6--
