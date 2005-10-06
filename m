Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVJFSel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVJFSel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVJFSek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:34:40 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:53157 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751292AbVJFSek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:34:40 -0400
Message-Id: <200510061834.j96IYPj1024268@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Your message of "Thu, 06 Oct 2005 11:31:59 +0200."
             <4344EF0F.90402@aitel.hist.no> 
From: Valdis.Kletnieks@vt.edu
References: <20051005095653.GK10538@lkcl.net> <200510051847.j95IlRTS012444@laptop11.inf.utfsm.cl> <20051005230309.GO10538@lkcl.net> <200510060803.j9683aXK026732@turing-police.cc.vt.edu>
            <4344EF0F.90402@aitel.hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128623665_4764P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Oct 2005 14:34:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128623665_4764P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Oct 2005 11:31:59 +0200, Helge Hafting said:

> You can have a restricted "copy" program, but nothing prevents a
> user from making his own copy program, if he can read the file.

Right, but a properly functioning and sufficiently fascist MAC system won't let
the user create a file in other security contexts that can be read by people
outside that context. See the recent work on supporting MLS (multi-level
security) and MCS (multi-category) in the SELinux tree...

> Or the user can load the file into the intended app, and "save as"

Again, "save as" doesn't create a file the other person can read unless the
other person is authorized.

> to some other filename and directory.  Or the user can do a screendump,

You *did* know that there's X hooks for Selinux, so that unauthorized applications
can't snarf the pixels of somebody else's window, right? ;)

> or even take a picture of the screen.

Not much we can do here.  On the other hand, it certainly creates a very low
upper limit on how much info you can extract how quickly... ;)

> Company policy may of course forbid the user to bring a camera, just as it
> might forbid the user to do "chmod o+r" on important files.  I am not
> sure that we need the OS to try to enforce such things. 

No, that is indeed outside the kernel's area.

--==_Exmh_1128623665_4764P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDRW4xcC3lWbTT17ARAs0oAKDZUYapFdas107hFE2JRMQgLYB7iQCfW5T3
Rheg5lqfAdU5ovPjKXxu9Ck=
=i6IJ
-----END PGP SIGNATURE-----

--==_Exmh_1128623665_4764P--
