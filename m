Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267103AbUBMREl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267129AbUBMREl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:04:41 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:57913 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267103AbUBMREi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:04:38 -0500
Message-Id: <200402131703.i1DH3oBY010590@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Angelo Dell'Aera" <buffer@antifork.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Giuliano Pochini <pochini@shiny.it>, Michael Frank <mhf@linuxmail.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle 
In-Reply-To: Your message of "Fri, 13 Feb 2004 17:38:15 +0100."
             <20040213173815.256d5bac.buffer@antifork.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040213124232.B2871@pclin040.win.tue.nl> <XFMail.20040213145513.pochini@shiny.it> <20040213153542.29686f0f.buffer@antifork.org> <200402131548.i1DFmECc020354@turing-police.cc.vt.edu>
            <20040213173815.256d5bac.buffer@antifork.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-380911138P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Feb 2004 12:03:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-380911138P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Feb 2004 17:38:15 +0100, "Angelo Dell'Aera" said:
> -----BEGIN PGP SIGNED MESSAGE-----

First, you said:

> >> which is not you. A simple use of inline functions and a previous thinking
 
> >> about what you're going to write could easily solve all problems. 

And now:

> I'm not saying "just inline anything and you'll solve problems". I'm saying
> that if your design is well done and you consider the availability of the
> inlines your code will surely be better. And maybe you wouldn't need to discu
ss
> why the current limit is 80...

I didn't claim it didn't help.  I objected to your claim that it would
"easily solve all problems".  It help, but isn't a cure-all.

(Sorry, I'm just touchy - after a quarter of a century of hearing "fixes
everything" claims for everything from "structured programming" to "extreme
programming", I tend to take extreme objection.. :)

> You could create a lot of examples where it's difficult to create an
> inline.. but they're just examples! There are a lot of ways for writing
> the same code and maybe if your example was taken from a real-life code
> it could be written in a different and more easy-to-read manner. 

4 tabs:
[/usr/src/linux-2.6.3-rc2-mm1]2 find . -name '*.[ch]' | xargs grep '\t\t\t\tgoto' | wc -l
    827

And 5:
[/usr/src/linux-2.6.3-rc2-mm1]2 find . -name '*.[ch]' | xargs grep '\t\t\t\t\tgoto' | wc -l
    183

Feel free to start fixing. :)


--==_Exmh_-380911138P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFALQN1cC3lWbTT17ARAtO9AKDlwBOATMTHkx3DtjXhYJwH2k2IRwCeLseX
u2fbTwIX9MODj947sfvJhKA=
=33O6
-----END PGP SIGNATURE-----

--==_Exmh_-380911138P--
