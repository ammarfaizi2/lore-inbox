Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUJGHow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUJGHow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 03:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269746AbUJGHow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 03:44:52 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:29824 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S267327AbUJGHoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 03:44:12 -0400
Date: Thu, 7 Oct 2004 09:44:04 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc3-mm2: compile error in irq.c
Message-ID: <20041007094404.30a6feb3@phoebee>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__7_Oct_2004_09_44_04_+0200__xtr.Uj971tb4TdT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__7_Oct_2004_09_44_04_+0200__xtr.Uj971tb4TdT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi there!

I don't know if someone already made a patch that's working, so I'm
posting the compile error here:

arch/i386/kernel/irq.c:203: error: redefinition of `is_irq_stack_ptr'
include/asm/hardirq.h:25: error: `is_irq_stack_ptr' previously defined here
arch/i386/kernel/irq.c: In function `is_irq_stack_ptr':
arch/i386/kernel/irq.c:207: error: `hardirq_stack' undeclared (first use in this function)
arch/i386/kernel/irq.c:207: error: (Each undeclared identifier is reported only once
arch/i386/kernel/irq.c:207: error: for each function it appears in.)
arch/i386/kernel/irq.c:210: error: `softirq_stack' undeclared (first use in this function)
make[1]: *** [arch/i386/kernel/irq.o] Error 1
make: *** [arch/i386/kernel] Error 2


Regards,
Martin

-- 
MyExcuse:
virus attack, luser responsible

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Thu__7_Oct_2004_09_44_04_+0200__xtr.Uj971tb4TdT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBZPPLmjLYGS7fcG0RAgruAJ9YxK/6bIU1cebN5KY9IIX7efpPiACgiuid
bzZm6UBXq7jfcJpQPzI5nMU=
=1YfG
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Oct_2004_09_44_04_+0200__xtr.Uj971tb4TdT--
