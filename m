Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVIWTL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVIWTL7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVIWTL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:11:59 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62373 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751172AbVIWTL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:11:58 -0400
Message-Id: <200509231911.j8NJBmaD007722@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrea Arcangeli <andrea@suse.de>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up 
In-Reply-To: Your message of "Fri, 23 Sep 2005 17:31:58 +0200."
             <20050923153158.GA4548@x30.random> 
From: Valdis.Kletnieks@vt.edu
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu> <200509231036.16921.kernel@kolivas.org> <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
            <20050923153158.GA4548@x30.random>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127502707_4428P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Sep 2005 15:11:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127502707_4428P
Content-Type: text/plain; charset=us-ascii

On Fri, 23 Sep 2005 17:31:58 +0200, Andrea Arcangeli said:
> Hello,
> 
> Can you try this updated patch? I believe the blk_congestion_wait is
> just wrong there, since there may be just one page being flushed. That
> sounds like a longstanding bug except it normally wouldn't trigger
> because the dirty levels never goes down near zero during heavy writes.
> 
> 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.1
4-rc1/per-task-predictive-write-throttling-3

Will do, although it may be Sunday night or Monday morning before I can report
back - just got handed a few higher-priority tasks...


--==_Exmh_1127502707_4428P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDNFNzcC3lWbTT17ARArspAJwJBWXgyiwe3/qz0L2DWmkglrtuYQCffAhL
n85ZpgD5k4FBzpdObI/+Lgc=
=zm2/
-----END PGP SIGNATURE-----

--==_Exmh_1127502707_4428P--
