Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTDNOMq (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTDNOMq (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:12:46 -0400
Received: from h80ad2720.async.vt.edu ([128.173.39.32]:14976 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263288AbTDNOMp (for <RFC822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 10:12:45 -0400
Message-Id: <200304141423.h3EENeu8003539@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4+dev
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages 
In-Reply-To: Your message of "Mon, 14 Apr 2003 14:40:46 +0300."
             <200304141145.h3EBjku02917@Port.imtp.ilyichevsk.odessa.ua> 
From: Valdis.Kletnieks@vt.edu
References: <200304111823_MC3-1-3412-C273@compuserve.com>
            <200304141145.h3EBjku02917@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1187622293P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Apr 2003 10:23:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1187622293P
Content-Type: text/plain; charset=us-ascii

On Mon, 14 Apr 2003 14:40:46 +0300, Denis Vlasenko said:

> OTOH "I can go read the source" is the ultimate documentation
> which we have for zero extra effort.

It's a non-zero extra effort for me to poke around in the source for
drivers/video/riva/fbdev.c trying to find what parameters are legal
to attach to 'video=rivafb' - at least one posting to LKML has listed
append="video=rivafb,xres:1024,yres:768,bpp:8" but looking at the
rivafb_setup() code that only checks for "forceCRTC", "flatpanel", and
"nomtrr" - so even MORE digging is needed to find out who parses the
xres, yres, bpp values, what other values are legal, etc etc.





--==_Exmh_1187622293P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+msRrcC3lWbTT17ARAibZAKDTncgpGr3zr73kKhRtCmgtdJWoMACfe/+q
apk84YYonWbXokdUzqKD2Nk=
=1vsb
-----END PGP SIGNATURE-----

--==_Exmh_1187622293P--
