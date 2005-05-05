Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVEEQDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVEEQDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVEEQDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:03:38 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54033 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262140AbVEEQDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:03:33 -0400
Message-Id: <200505051603.j45G3Tdq015914@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: kylin <fierykylin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: telnet bug in fedora Core 4 test 2 
In-Reply-To: Your message of "Thu, 05 May 2005 23:42:46 +0800."
             <87ab37ab050505084254521f08@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <87ab37ab050505084254521f08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115309008_3889P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 05 May 2005 12:03:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115309008_3889P
Content-Type: text/plain; charset=us-ascii


> when i try to start it  using telnetd....
> then error evolves like this: 
> telnetd:get peername:socket operation on non-socket

That's not a telnetd bug, that's a user bug.  Two, in fact:

1) telnetd is telling you that you tried to start it by hand, and it *really*
wants to be started by inetd/xinetd.

2) This isn't a kernel problem.

--==_Exmh_1115309008_3889P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCekPQcC3lWbTT17ARAubWAJ47COkBCeMb5IkBneK4VolThp0B7ACZAZUI
uZIxVg2rK6PGjzOT35nggVw=
=8OcL
-----END PGP SIGNATURE-----

--==_Exmh_1115309008_3889P--
