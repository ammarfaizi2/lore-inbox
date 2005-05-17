Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVEQRip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVEQRip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVEQReW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:34:22 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62735 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261864AbVEQRao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:30:44 -0400
Message-Id: <200505171730.j4HHUXMQ021385@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, mbligh@mbligh.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI) 
In-Reply-To: Your message of "Tue, 17 May 2005 00:15:42 PDT."
             <20050517001542.40e6c6b7.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <42822B5F.8040901@sw.ru> <768860000.1116282855@flay> <42899797.2090702@sw.ru>
            <20050517001542.40e6c6b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116351030_5349P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 May 2005 13:30:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116351030_5349P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 May 2005 00:15:42 PDT, Andrew Morton said:

> So much has changed in there that we might have fixed it by accident, and I
> do recall a couple of fundamental and subtle NMI bugs being fixed.  So
> yeah, it might be worth enabling it by default again.  Care to send a patch
> which does that?

There's still boxes with borked LAPICs out there - or will the "borked lapic"
code override the NMI handler?

--==_Exmh_1116351030_5349P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCiio2cC3lWbTT17ARAmQTAKCZyuWEybXQhmsLiM8U1xqTrWeT/QCg3NgX
jO0UIDAwNoVXyTjuCADwpfg=
=x+CO
-----END PGP SIGNATURE-----

--==_Exmh_1116351030_5349P--
