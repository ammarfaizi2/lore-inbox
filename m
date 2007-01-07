Return-Path: <linux-kernel-owner+w=401wt.eu-S932286AbXAGA3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbXAGA3f (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 19:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbXAGA3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 19:29:35 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39204 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286AbXAGA3e (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 19:29:34 -0500
Message-Id: <200701070029.l070TPNT004347@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3-mm1 - rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues.patch
In-Reply-To: Your message of "Sat, 06 Jan 2007 17:59:06 +0100."
             <20070106165906.GK13533@inferi.kami.home>
From: Valdis.Kletnieks@vt.edu
References: <20070104220200.ae4e9a46.akpm@osdl.org> <200701061344.l06DipYC003610@turing-police.cc.vt.edu>
            <20070106165906.GK13533@inferi.kami.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168129765_4071P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 06 Jan 2007 19:29:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168129765_4071P
Content-Type: text/plain; charset=us-ascii

On Sat, 06 Jan 2007 17:59:06 +0100, Mattia Dongili said:
> On Sat, Jan 06, 2007 at 08:44:51AM -0500, Valdis.Kletnieks@vt.edu wrote:
> > One of these 3 patches:
> > 
> > rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues.patch

> Does the following help?
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> ---
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a7b17ab..1112f31 100644

Yes, that fixes the problem.  Thanks.

--==_Exmh_1168129765_4071P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFoD7lcC3lWbTT17ARAi/fAKDPN7JN4OfgFntyh6gLVnoahYbPvQCg6tm4
v2m02KXdx0R8B97UlYe2Jzs=
=YRC6
-----END PGP SIGNATURE-----

--==_Exmh_1168129765_4071P--
