Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUBDT6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 14:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUBDT6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 14:58:48 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4483 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264147AbUBDT6r (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 14:58:47 -0500
Message-Id: <200402041958.i14JwiMt010304@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Randazzo, Michael" <RANDAZZO@ddc-web.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.x POSIX Compliance/Conformance... 
In-Reply-To: Your message of "Wed, 04 Feb 2004 14:44:00 EST."
             <89760D3F308BD41183B000508BAFAC4104B16F34@DDCNYNTD> 
From: Valdis.Kletnieks@vt.edu
References: <89760D3F308BD41183B000508BAFAC4104B16F34@DDCNYNTD>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1157068353P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Feb 2004 14:58:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1157068353P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 Feb 2004 14:44:00 EST, "Randazzo, Michael" said:
> I was using at sem_close(), sem_destroy90, sem_open() ...
> 
> according to Posix.4, these are defined in semaphore.h - but
> are not defined in /lib/modules/<uname -r>/build/include/semaphore.h
> 
> Are Posix.4 calls only for userspace?

System calls in general are for userspace.  Often, there exist alternate
entry points for kernel services, or other ways to do it (for instance,
the kernel has its own code for locks and semaphores).

--==_Exmh_1157068353P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIU7zcC3lWbTT17ARAiijAKCPLBGRtbI29JFIzeVgwXIUppcL+QCeNVoE
UjXgmM82H4umIYKW3D05BJk=
=/TWs
-----END PGP SIGNATURE-----

--==_Exmh_1157068353P--
