Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264505AbUENG1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUENG1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 02:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUENG1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 02:27:12 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:58023 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264316AbUENGZb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 02:25:31 -0400
Message-Id: <200405140625.i4E6PRjB027161@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Chris Wright <chrisw@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities, take 3 (Re: [PATCH] capabilites, take 2) 
In-Reply-To: Your message of "Thu, 13 May 2004 22:40:42 PDT."
             <20040513224042.O21045@build.pdx.osdl.net> 
From: Valdis.Kletnieks@vt.edu
References: <200405131308.40477.luto@myrealbox.com> <20040513182010.L21045@build.pdx.osdl.net> <200405131945.53723.luto@myrealbox.com> <20040513220415.E22989@build.pdx.osdl.net> <200405140532.i4E5WF4p006799@turing-police.cc.vt.edu>
            <20040513224042.O21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_956855753P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 14 May 2004 02:25:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_956855753P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 May 2004 22:40:42 PDT, Chris Wright said:

> OK, this is precisely POSIX as I expected.  No surprise given the folks
> involved.

Hmm... Chris? Andy?  *Exactly* what version of the draft are you both looking at?

I ask because Andy Lutomirski's draft had *different* production rules:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106687456724871&w=2

And I think everybody managed to miss this gotcha (I know I did):

Albert Calahan reported that apparently a lot of people worked off the N-1 version
of the draft, and the equation that's giving us the trouble got changed:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106687419224640&w=2

I wonder if Andy and I were convinced that the Posix draft 16 that people
worked from was broken because it was, but the Posix draft 17 (that looks
like the SGI stuff) was more correct but didn't get seen by everybody?


--==_Exmh_956855753P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFApGZXcC3lWbTT17ARArZOAKDfKHjpIwuT15zC5oZWaefbKr9fvACgjd85
3IiIeOZ31sBptBcjxwzpa5E=
=zMoQ
-----END PGP SIGNATURE-----

--==_Exmh_956855753P--
