Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270000AbTGQJbD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271353AbTGQJbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:31:03 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:39552 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S270000AbTGQJa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:30:59 -0400
Date: Thu, 17 Jul 2003 11:45:48 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.0-t1-ac2: unable to compile glibc 2.3.2
Message-Id: <20030717114548.5f5d506d.martin.zwickel@technotrend.de>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.0claws93 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.kaN0b'qb7t+oSK"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.kaN0b'qb7t+oSK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi there!

I just tried to update my glibc to 2.3.2 and saw that glibc can't compile
because of linux/sysctl.h.

I added the line "#include <linux/compiler.h>" to sysctl.h.
(since sysctl needs the __user)

So someone forgot the line, or did I miss something?

Regards,
Martin

-- 
MyExcuse:
boss forgot system password

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--=.kaN0b'qb7t+oSK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FnBOmjLYGS7fcG0RAj/eAJ97yKzZhRWvkE3axZiPWo0v9M4BDwCeLfJj
Lh2p8gIyAI6H1VpEjK7oxd4=
=wVpR
-----END PGP SIGNATURE-----

--=.kaN0b'qb7t+oSK--
