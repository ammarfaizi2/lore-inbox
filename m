Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbUKQUum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbUKQUum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUKQUsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:48:39 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:6016 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262472AbUKQUrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:47:12 -0500
Message-Id: <200411172047.iAHKl1DE004845@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pid_max madness 
In-Reply-To: Your message of "Wed, 17 Nov 2004 21:12:07 +0100."
             <419BB097.8030405@kde.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <419BB097.8030405@kde.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1588431168P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Nov 2004 15:47:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1588431168P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 Nov 2004 21:12:07 +0100, Grzegorz Piotr Jaskiewicz said:

> Anyway, does it mean that after max unsigned value is reached pids are 
> going to be negative in value ??

No, because something in the /proc drivers will die of indigestion *much*
sooner (I think it's some very low value like 64K or 128K on i386?)


--==_Exmh_1588431168P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBm7jEcC3lWbTT17ARAjh/AJ43lH8Iz1n+dGyQkJvGcAihItjTGgCg7wRt
GQWxDEfBfDDCK3mBOEiw7HA=
=E20b
-----END PGP SIGNATURE-----

--==_Exmh_1588431168P--
