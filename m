Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVJEFgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVJEFgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 01:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVJEFgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 01:36:23 -0400
Received: from h80ad258b.async.vt.edu ([128.173.37.139]:1952 "EHLO
	h80ad258b.async.vt.edu") by vger.kernel.org with ESMTP
	id S932303AbVJEFgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 01:36:23 -0400
Message-Id: <200510050535.j955ZwVE021603@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Chase Venters <chase.venters@clientec.com>
Cc: Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Your message of "Tue, 04 Oct 2005 18:40:33 CDT."
             <200510041840.55820.chase.venters@clientec.com> 
From: Valdis.Kletnieks@vt.edu
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com>
            <200510041840.55820.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128490557_2752P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Oct 2005 01:35:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128490557_2752P
Content-Type: text/plain; charset=us-ascii

On Tue, 04 Oct 2005 18:40:33 CDT, Chase Venters said:
> Work on dbus and HAL should give us good improvements in these areas. One
> remaining challenge I see is system configuration - each daemon tends to
> adopt its own syntax for configuration, which means that providing a GUI for
> novice users to manage these systems means attacking each problem separately 
> and in full. Now I certainly wouldn't advocate a Windows-style registry,
> because I think it's full of obvious problems. Nevertheless, it would be nice
> to have some kind of configuration editor abstraction library that had some
> sort of syntax definition database to allow for some interesting work on
> GUIs.

Anybody who tries to do this without at least understanding the design choices
made by AIX's SMIT tool deserves to re-invent it, poorly.

> In any case, I think pretty much all of this work lives outside the kernel.

Amen to that - although the whole hotplug/udev/sysfs aggregation has at least
made a semi-sane way to find out from userspace what the kernel thinks is going on...

Are there any drivers out there that don't play nice with sysfs? If so, should
a mention of them be added to http://kerneljanitors.org/TODO ?


--==_Exmh_1128490557_2752P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQ2Y9cC3lWbTT17ARAtr+AKD0QTbMdvgrNyqu+qIWVSN5QOshFACfVX6Z
m6obBzLt4FEeTbei8fCyR9I=
=HnXY
-----END PGP SIGNATURE-----

--==_Exmh_1128490557_2752P--
