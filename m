Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263718AbUFBRqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUFBRqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUFBRqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:46:00 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40923 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263718AbUFBRp6 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:45:58 -0400
Message-Id: <200406021745.i52HjmAT013644@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Tim Connors <tconnors+linuxkernel1086148031@astro.swin.edu.au>
Cc: FabF <fabian.frederick@skynet.be>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all? 
In-Reply-To: Your message of "Wed, 02 Jun 2004 13:50:42 +1000."
             <slrn-0.9.7.4-13727-23491-200406021347-tc@hexane.ssi.swin.edu.au> 
From: Valdis.Kletnieks@vt.edu
References: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net> <1086114982.2278.5.camel@localhost.localdomain> <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu>
            <slrn-0.9.7.4-13727-23491-200406021347-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1353046712P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jun 2004 13:45:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1353046712P
Content-Type: text/plain; charset=us-ascii

On Wed, 02 Jun 2004 13:50:42 +1000, Tim Connors said:

> I do often get frustrated that the DoS card is brought up to kill a
> potentially useful solution. I think there should be a flag in KConfig
> saying "This machine will be a server"/"This machine will be mostly a
> single user desktop machine". In the latter, you can enable all these
> vm/etc heuristics that will help out mozilla/X/your favourite
> bloat-ware, but potentially enable a DoS attack, and in the former,
> you stay conservative.

And with that, you've worried about whether it's a potential DoS or
not.  I didn't bring it up to "kill" it - I brought it up to start a discussion,
because I felt that including that sort of feature without at least thinking
about the DoS issues was a bad idea.  Shipping it with a Kconfig or
sysctl flag, or using the capabilities framework, or any other similar
"allow the sysadmin to control it" feature is a different matter entirely...


--==_Exmh_1353046712P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvhJMcC3lWbTT17ARAll2AJ9e+Ps+APunNs2JCWiqd7ivvvrGsACfdLv7
HHLd/T39TS0I6Qu3KwEyyRI=
=BhJS
-----END PGP SIGNATURE-----

--==_Exmh_1353046712P--
