Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbTGOODM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbTGOODM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:03:12 -0400
Received: from h80ad2707.async.vt.edu ([128.173.39.7]:48538 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267852AbTGOODJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:03:09 -0400
Message-Id: <200307151417.h6FEHkMQ010873@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Tupshin Harper <tupshin@tupshin.com>
Cc: "Ranga Reddy M - CTD ,Chennai." <rangareddym@ctd.hcltech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: setting year to 2094 casuing Error. 
In-Reply-To: Your message of "Mon, 14 Jul 2003 23:35:35 PDT."
             <3F13A0B7.6050103@tupshin.com> 
From: Valdis.Kletnieks@vt.edu
References: <EF836A380096D511AD9000B0D021B5270153C968@narmada.techmas.hcltech.com>
            <3F13A0B7.6050103@tupshin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1295932768P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Jul 2003 10:17:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1295932768P
Content-Type: text/plain; charset=us-ascii

On Mon, 14 Jul 2003 23:35:35 PDT, Tupshin Harper said:
> Ranga Reddy M - CTD ,Chennai. wrote:
> >I have set the system time from BIOS to 17/03/2094.After setting this
> >,booted with linux O.S. 
> >
> >Now its showing system date as year=1994.I did not get how this happend.

> http://www.howstuffworks.com/question75.htm

Yes, but if it was a 2038 problem, you'd expect a date in 2094 to roll over to 2026 (as
2094 is 56 years past 2038, and 2026 is 56 past 1970).

I suspect he has a crippled clock chip that only keeps 2 digits of year.

--==_Exmh_1295932768P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/FA0IcC3lWbTT17ARAnHEAKDO9roiSJ/nxZY2A/j6BksQvj8C4gCdHGyK
dz2PbrFHUv8QCj9HNos0nzY=
=W/EV
-----END PGP SIGNATURE-----

--==_Exmh_1295932768P--
