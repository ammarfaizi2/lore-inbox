Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUADUew (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 15:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUADUew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 15:34:52 -0500
Received: from h80ad253c.async.vt.edu ([128.173.37.60]:26279 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263424AbUADUev (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 15:34:51 -0500
Message-Id: <200401042034.i04KYm1P024587@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Rob Love <rml@ximian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6 
In-Reply-To: Your message of "Sun, 04 Jan 2004 11:33:08 EST."
             <1073233988.5225.9.camel@fur> 
From: Valdis.Kletnieks@vt.edu
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <1073228608.2717.39.camel@fur> <20040104162516.GB31585@redhat.com>
            <1073233988.5225.9.camel@fur>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_873559510P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Jan 2004 15:34:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_873559510P
Content-Type: text/plain; charset=us-ascii

On Sun, 04 Jan 2004 11:33:08 EST, Rob Love said:

> I actually like this patch (perhaps since I have a P-M :) and think it
> ought to go in, although I agree with others that the P-M is more of a
> super-P3 than a scaled down P4.

Same here - /proc/cpuinfo says:

vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz

Question for those more knowledgeable: Are there any known Pentium4 features
enabled in the kernel with the PENTIUM4 options that simply Will Not Work on a
4M chipset (similar to a kernel built for a 586 not working on a 486), or are
the differences limited to "sub-optimal performance" (for example, compiling
with -mpentium4 results in code that runs but schedules less optimally)?  If
there are, they must be fairly obscure corner cases, since I haven't knowingly
hit one in several months.. :)

2.7 timeframe - are there any added features of a P4 core we would *like*
to exploit that aren't on a P4M?

--==_Exmh_873559510P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+HjncC3lWbTT17ARAkFkAJ9AsX5R/v6msInljHkPs0eTJ/EkRgCfUnzi
E4ShLnhhTH+NZ7mbd5DjgY0=
=lIZi
-----END PGP SIGNATURE-----

--==_Exmh_873559510P--
