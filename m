Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbTA1RhN>; Tue, 28 Jan 2003 12:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267649AbTA1RhM>; Tue, 28 Jan 2003 12:37:12 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:34689 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267645AbTA1RhL>; Tue, 28 Jan 2003 12:37:11 -0500
Message-Id: <200301281746.h0SHkOgM007373@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Steven Dake <sdake@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: New model for managing dev_t's for partitionable block devices 
In-Reply-To: Your message of "Tue, 28 Jan 2003 10:20:31 MST."
             <3E36BBDF.4090104@mvista.com> 
From: Valdis.Kletnieks@vt.edu
References: <3F61ABC3.1080502@tin.it>
            <3E36BBDF.4090104@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571606832P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Jan 2003 12:46:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1571606832P
Content-Type: text/plain; charset=us-ascii

On Tue, 28 Jan 2003 10:20:31 MST, Steven Dake <sdake@mvista.com>  said:

> Each physical disk would be assigned a minor number in a group of 
> majors.  So assume a major was chosen of 150, 151, 152, 153, there would 
> be a total of 1024 physical disks that could be mapped.  Then the device 
> mapper code could be used to provide partition devices in another 
> major/group of majors.

This sounds suspiciously like the already-existing device mapper stuff
used by LVM2.  Maybe all that's needed is to add a hook to add a device
mapper entry for each partition?
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_1571606832P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+NsHwcC3lWbTT17ARApmBAKCRkTCNCatnC0dh2LLT9xFjc17oYgCgiMn9
E7GhpNUR8o9wklRRAKUwm74=
=GHMk
-----END PGP SIGNATURE-----

--==_Exmh_1571606832P--
