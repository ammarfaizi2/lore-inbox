Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVEJUTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVEJUTR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVEJUTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:19:16 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:64516 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261759AbVEJUTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:19:01 -0400
Message-Id: <200505102018.j4AKIRT3022492@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: paulmck@us.ibm.com, dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress 
In-Reply-To: Your message of "Tue, 10 May 2005 22:08:11 +0200."
             <1115755692.26548.15.camel@twins> 
From: Valdis.Kletnieks@vt.edu
References: <20050510012444.GA3011@us.ibm.com>
            <1115755692.26548.15.camel@twins>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115756303_8169P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 10 May 2005 16:18:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115756303_8169P
Content-Type: text/plain; charset=us-ascii

On Tue, 10 May 2005 22:08:11 +0200, Peter Zijlstra said:

> How about having another boolean indicating the ability to flip the
> selector boolean. This boolean would be set false on an actual flip and
> cleared during a grace period. That way the flips cannot ever interfere
> with one another such that the callbacks would be cleared prematurely.

As all the dining philosophers grab a fork and a spoon and dig in. ;)

--==_Exmh_1115756303_8169P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCgRcOcC3lWbTT17ARAuBkAKCkdoncNR8QDTN0v3LMC+/q1cSrNwCfalbE
C0v0rx2gTET5jmi+KS/mxNU=
=jw8c
-----END PGP SIGNATURE-----

--==_Exmh_1115756303_8169P--
