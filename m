Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVERAET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVERAET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVERAET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:04:19 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1029 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261748AbVERAEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:04:01 -0400
Message-Id: <200505180003.j4I03cJo008917@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lee Revell <rlrevell@joe-job.com>
Cc: christoph <christoph@scalex86.org>, George Anzinger <george@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, shai@scalex86.org,
       akpm@osdl.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt. 
In-Reply-To: Your message of "Tue, 17 May 2005 19:25:41 EDT."
             <1116372341.32210.39.camel@mindpipe> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw> <1116276689.28764.1.camel@mindpipe> <Pine.LNX.4.62.0505161755110.9418@ScMPusgw>
            <1116372341.32210.39.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116374618_5349P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 May 2005 20:03:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116374618_5349P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 May 2005 19:25:41 EDT, Lee Revell said:

> How do you expect application developers to handle not being able to
> count on the resolution of nanosleep()?  Currently they can at least
> assume 10ms on 2.4, 1ms on 2.6.  Seems to me that if you are no longer
> guaranteed to be able to sleep 5ms on 2.6, you would just have to
> busywait.  Is it me, or does that way lie madness?

If you're running tickless, wouldn't a 'sleep 5ms' cause a timer event to be
queued, and we wake up (approx) 5ms later?

--==_Exmh_1116374618_5349P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCioZacC3lWbTT17ARAvxYAJ4jhASe2PD1esteazQireEMm4P/NwCguOPz
J91CNJ95nl3hHRgOwnNQb4Y=
=btUI
-----END PGP SIGNATURE-----

--==_Exmh_1116374618_5349P--
