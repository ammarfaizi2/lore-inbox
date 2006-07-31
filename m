Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWGaOMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWGaOMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWGaOMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:12:40 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33711 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932334AbWGaOMj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:12:39 -0400
Message-Id: <200607311412.k6VECX1G004087@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Preserving uptime with kexec?
In-Reply-To: Your message of "Mon, 31 Jul 2006 08:59:13 EDT."
             <20060731125913.GA27083@phoenix>
From: Valdis.Kletnieks@vt.edu
References: <20060731125913.GA27083@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154355153_3409P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 10:12:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154355153_3409P
Content-Type: text/plain; charset=us-ascii

On Mon, 31 Jul 2006 08:59:13 EDT, Thomas Tuttle said:
> Like many people, I like to brag about how great my uptime is.  But like
> many other people, I like to keep my kernel up-to-date with the latest
> and greatest from kernel.org.  I recently discovered the magic of kexec,
> which allows me to switch kernels without rebooting for real.
> Unfortunately, kexec resets my uptime when it runs.

The reset of uptime is probably a Good Thing.  Consider the case of
a kernel memory leak - you look in /proc/meminfo and find that you've managed
to lose 64 meg of memory to the leak.  Where you start looking for the
leak will depend on whether it's 64 meg lost across 4 weeks since the
last boot, or the 30 minutes since the last boot.

(Speaking as somebody who's run into both classes of leaks...)



--==_Exmh_1154355153_3409P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEzg/RcC3lWbTT17ARAjfFAJ4lo1w5Uyu3HsBHeT3QLG0bmgAdtQCfe0m6
YJviYpF0yq5H3wPtpmjfHI8=
=58z3
-----END PGP SIGNATURE-----

--==_Exmh_1154355153_3409P--
