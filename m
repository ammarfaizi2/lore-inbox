Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTAJRFK>; Fri, 10 Jan 2003 12:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbTAJRFJ>; Fri, 10 Jan 2003 12:05:09 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48512 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265523AbTAJRFG>; Fri, 10 Jan 2003 12:05:06 -0500
Message-Id: <200301101713.h0AHDmLK010383@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup 
In-Reply-To: Your message of "Fri, 10 Jan 2003 17:12:12 +0100."
             <20030110161212.GA11193@wotan.suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <1042192419.1415.49.camel@cast2.alcatel.ch> <Pine.LNX.4.44.0301101428420.1292-100000@localhost.localdomain> <20030110160334.GU23814@holomorphy.com>
            <20030110161212.GA11193@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-339223764P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Jan 2003 12:13:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-339223764P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jan 2003 17:12:12 +0100, Andi Kleen <ak@suse.de>  said:
> 
> > So the end-result of the discussion is, "What should really happen here?"
> > and "What, if anything, do you want me to do?"
> 
> IMHO best would be to get rid of /proc/*/wchan and keep the kallsyms 
> lookup slow, simple and stupid.

And replace the current /proc/*/wchan functionality with what?
(Note that saying "read the System.map file from userspace" doesn't *quite*
work, as I may be running a kernel that doesn't have System.map installed
someplace easily findable.  At the moment my /boot partition has 6 assorted
vmlinuz-\(*\) files, only 4 of which have System.map-\1 files matching).

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-339223764P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Hv9McC3lWbTT17ARAn8fAJ9gALd32bjXGMUAlPLZCy3xb4+7zgCg68ZH
NkYnap5Juq8hwKrOFYE7UOI=
=3pBY
-----END PGP SIGNATURE-----

--==_Exmh_-339223764P--
