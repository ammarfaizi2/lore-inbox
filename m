Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269698AbUIRXh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269698AbUIRXh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269682AbUIRXex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:34:53 -0400
Received: from [63.227.221.253] ([63.227.221.253]:15237 "EHLO home.keithp.com")
	by vger.kernel.org with ESMTP id S269690AbUIRXeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:34:31 -0400
X-Mailer: exmh version 2.3.1 11/28/2001 with nmh-1.1
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Mike Mestnik <cheako911@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Keith Packard <keithp@keithp.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes 
From: Keith Packard <keithp@keithp.com>
In-Reply-To: Your message of "Sat, 18 Sep 2004 18:12:17 EDT."
             <9e47339104091815125ef78738@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_80760304P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 18 Sep 2004 16:33:54 -0700
Message-Id: <E1C8oiI-0001xU-UG@evo.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_80760304P
Content-Type: text/plain; charset=us-ascii


Around 18 o'clock on Sep 18, Jon Smirl wrote:

> The sysfs scheme has the advantage that there is no special user
> command required. You just use echo or cp to set the mode.

But it makes it difficult to associate the sysfs entry with the particular 
session.  Seems like permitting multiple opens of /dev/fb0 with mode 
setting done on that file pointer will be easier to keep straight



--==_Exmh_80760304P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.3.1 11/28/2001

iD8DBQFBTMXiQp8BWwlsTdMRAtWYAJ4+kF5fwJeEMohpFuApbpYeHErj7gCfZJMm
LVLtoJ/py7g03vVZOOPGyZo=
=t/TL
-----END PGP SIGNATURE-----

--==_Exmh_80760304P--
