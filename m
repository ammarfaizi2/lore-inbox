Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWJLShy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWJLShy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWJLShy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:37:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:59277 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750972AbWJLShx (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:37:53 -0400
Message-Id: <200610121837.k9CIbdwg004673@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       johnstul@us.ibm.com
Subject: Re: 2.6.19-rc1-mm1
In-Reply-To: Your message of "Tue, 10 Oct 2006 00:09:28 PDT."
             <20061010000928.9d2d519a.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20061010000928.9d2d519a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1160678258_2844P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Oct 2006 14:37:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1160678258_2844P
Content-Type: text/plain; charset=us-ascii

On Tue, 10 Oct 2006 00:09:28 PDT, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/

> - Added the high-resolution timers and dynamic-ticks code.  Please be sure
>  to cc tglx@linutronix.de>, mingo@elte.hu and johnstul@us.ibm.com if it blows
>  up.

Compiles, boots, and behaves on my Dell Latitude C840 that previously had
indigestion.  It selected the ACPI-PM timesource right off the bat (for reasons
I don't understand, previous dynticks used the tsc timesource), so I'm not
seeing the huge clock drift issues I had with previous dyntick patches when
running 'cpuspeed' - it drops from 1.6Ghz to 1.2Ghz and back without a problem.


--==_Exmh_1160678258_2844P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFLotycC3lWbTT17ARAn3RAJ4jKygowB+s8nOPLr+WuWZkqKfRhQCfTM2B
BqJZGmeR6yC6g0fVTSa6bjk=
=Kdps
-----END PGP SIGNATURE-----

--==_Exmh_1160678258_2844P--
