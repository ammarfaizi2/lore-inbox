Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVJDTny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVJDTny (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVJDTny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:43:54 -0400
Received: from h80ad24a7.async.vt.edu ([128.173.36.167]:30168 "EHLO
	h80ad24a7.async.vt.edu") by vger.kernel.org with ESMTP
	id S964939AbVJDTnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:43:53 -0400
Message-Id: <200510041943.j94Jhj4C007314@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The price of SELinux (CPU) 
In-Reply-To: Your message of "Tue, 04 Oct 2005 14:29:05 EDT."
             <4342C9F1.2000005@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <434204F8.2030209@comcast.net> <200510041539.j94FdJmO028772@turing-police.cc.vt.edu>
            <4342C9F1.2000005@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128455024_2697P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Oct 2005 15:43:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128455024_2697P
Content-Type: text/plain; charset=us-ascii

On Tue, 04 Oct 2005 14:29:05 EDT, John Richard Moser said:

> Aside from this, viruses and spyware and worms can now run rampant and
> do what they want to his system, and other users' idiotic actions on a
> multi-user system affect him.  This is more user friendly?  No, I think
> it's going in the opposite direction. . . .

Virus writers are users too, you know.  :)

And the other users are users as well - what if the other user's "idiotic
action" is to nuke your 500Mbyte archive of alt.binaries.pictures.llama.sex
that's taking up the disk space that is keeping him from running the payroll
software?  In your world, rather than him being able to fix the problem, he has
to go find a sysadmin with the root password to fix it, causing delays and
being less friendly....

You seem to be intentionally trying to miss the basic point, which is that
any additional security ends up trading off against other things.

Non-execute stack is a Good Thing security-wise - but it breaks some code,
forcing upgrades and/or having to track down binaries and flag them as
"don't enforce NX stack".  And then those binaries are still vulnerable....

SELinux is, in general, also a Good Thing.  However, the fact that the policy
restricts what stuff can happen in the security context associated with
mail delivery (after all, you *don't* want arbitrary binaries running then, right?)
did some serious damage to the way I use procmail, which in some cases ended
up running other binaries.  OK, so my .procmailrc *is* a 600-line monster that
does a lot of odd stuff - the point was that I had to add even *more* contortions
to the way it works, which is even less user-friendly....



--==_Exmh_1128455024_2697P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQttwcC3lWbTT17ARAjSmAJ9VL+8xMynEcON/l7PT6Sceb08emQCgwd0/
p97YdgagBMy+8lDY08PEpMo=
=F7XO
-----END PGP SIGNATURE-----

--==_Exmh_1128455024_2697P--
