Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTJHNih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTJHNiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:38:15 -0400
Received: from h80ad2664.async.vt.edu ([128.173.38.100]:61316 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261566AbTJHNbz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:31:55 -0400
Message-Id: <200310081331.h98DVLow016839@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Bill J.Xu" <xujz@neusoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a login question 
In-Reply-To: Your message of "Wed, 08 Oct 2003 14:36:43 +0800."
             <001b01c38d66$89d31ac0$2a02010a@avwindows> 
From: Valdis.Kletnieks@vt.edu
References: <001b01c38d66$89d31ac0$2a02010a@avwindows>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1416683293P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Oct 2003 09:31:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1416683293P
Content-Type: text/plain; charset=us-ascii

On Wed, 08 Oct 2003 14:36:43 +0800, "Bill J.Xu" <xujz@neusoft.com>  said:

> how to conceal the hostname information--abc? that is the welcome messenge as
 following:

1) This is off-topic for a *kernel* list.

2) This is bogus security - they telnet'ed to the machine, they already *know*
its name/IP address.  You should leave the hostname in so legitimate users can
verify they've gotten to the *right* machine (what, you've never had a server farm
with dozens/hundreds of machines and typed 'telnet foo23' when you meant
'telnet foo24'?)

3) You should be using SSH instead.

4) /usr/sbin/telnetd invokes /bin/login which calls pam.  The hostname gets
printed after telnetd does /etc/issue.  Since I think it's a bad idea, that's
all the hints I'm giving today.  The answer can be found in the telnet, util-linux,
and/or PAM src.rpm's.  If you're going to mess with this, you should learn how
it works, and reading the source is a good way to do that...



--==_Exmh_1416683293P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/hBGocC3lWbTT17ARAq8VAKDDOQKBcqQlPstOtVRt/m+rpCke1QCgue7V
H2BoeclU2uFIrweJzeEJ484=
=RaVg
-----END PGP SIGNATURE-----

--==_Exmh_1416683293P--
