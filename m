Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752125AbWKGNMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbWKGNMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbWKGNMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:12:47 -0500
Received: from lugor.de ([212.112.242.222]:29085 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1752125AbWKGNMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:12:46 -0500
From: "Hesse, Christian" <mail@earthworm.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 12/14] KVM: x86 emulator
Date: Tue, 7 Nov 2006 14:12:02 +0100
User-Agent: KMail/1.9.4
Cc: Pavel Machek <pavel@ucw.cz>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <454E4941.7000108@qumranet.com> <20061107124912.GA23118@elf.ucw.cz> <4550823E.2070108@qumranet.com>
In-Reply-To: <4550823E.2070108@qumranet.com>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8496485.T9ueW8W05g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611071412.07196.mail@earthworm.de>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (solar.mylinuxtime.de [10.5.1.1]); Tue, 07 Nov 2006 14:12:04 +0100 (CET)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8496485.T9ueW8W05g
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 07 November 2006 13:55, Avi Kivity wrote:
> Pavel Machek wrote:
> >> Index: linux-2.6/drivers/kvm/x86_emulate.c
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> --- /dev/null
> >> +++ linux-2.6/drivers/kvm/x86_emulate.c
> >> @@ -0,0 +1,1370 @@
> >> +/********************************************************************=
**
> >>******** + * x86_emulate.c
> >> + *
> >> + * Generic x86 (32-bit and 64-bit) instruction decoder and emulator.
> >> + *
> >> + * Copyright (c) 2005 Keir Fraser
> >> + *
> >> + * Linux coding style, mod r/m decoder, segment base fixes, real-mode
> >> + * privieged instructions:
> >> + *
> >> + * Copyright (C) 2006 Qumranet
> >> + *
> >> + *   Avi Kivity <avi@qumranet.com>
> >> + *   Yaniv Kamay <yaniv@qumranet.com>
> >> + *
> >> + * From: xen-unstable 10676:af9809f51f81a3c43f276f00c81a52ef558afda4
> >> + */
> >
> > This needs GPL, I'd say.
> > 									Pavel
>
> The entire patchset is GPL'ed.  Do you mean to make it explicit?  If so,
> how?  I'd rather not copy the entire license into each file.
>
> Doesn't ../../COPYING cover it, presuming it's accepted?

I think Pavel references to these lines...

/*
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
 */

You should at least add a line like "This file is licensed under the terms =
of=20
the GPL v2 license (or any later version).".
=2D-=20
Regards,
Chris

--nextPart8496485.T9ueW8W05g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFUIYnlZfG2c8gdSURAhJeAJ40OoiSfMJ68Stqa9F00zLvFExI6ACfZGsi
r6jPNML0FMHVZrXLqqv7jGU=
=OhAj
-----END PGP SIGNATURE-----

--nextPart8496485.T9ueW8W05g--
