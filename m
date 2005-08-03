Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVHCUIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVHCUIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 16:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVHCUIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 16:08:04 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13457 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262440AbVHCUHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 16:07:32 -0400
Message-Id: <200508032007.j73K7E2o007651@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3 
In-Reply-To: Your message of "Wed, 03 Aug 2005 14:54:40 CDT."
             <42F12100.5020006@mnsu.edu> 
From: Valdis.Kletnieks@vt.edu
References: <200508031559.24704.kernel@kolivas.org>
            <42F12100.5020006@mnsu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1123099634_3357P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 03 Aug 2005 16:07:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1123099634_3357P
Content-Type: text/plain; charset=us-ascii

On Wed, 03 Aug 2005 14:54:40 CDT, Jeffrey Hundstad said:

> BTW: how do you know what HZ your machine is running at?

% zcat /proc/config.gz | grep -i hz

might do what you thought you wanted.

What rate you're *actually* running at is probably best done by taking the
number of timer interrupts from /proc/interrupts and dividing by the
uptime in /proc/uptime....

--==_Exmh_1123099634_3357P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC8SPycC3lWbTT17ARAsSDAJ9qytzokLQHjUQPhMaC1yLIgs7vQgCdHP7/
cHfAikEOsAm6eMP1Nn1W+Zc=
=9pVX
-----END PGP SIGNATURE-----

--==_Exmh_1123099634_3357P--
