Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267091AbUBMQB3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267094AbUBMQB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:01:29 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47084 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267091AbUBMQB1 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:01:27 -0500
Message-Id: <200402131601.i1DG1Nsl020006@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why are capabilities disabled? 
In-Reply-To: Your message of "Fri, 13 Feb 2004 16:29:28 +0100."
             <c0iqrq$erh$1@sea.gmane.org> 
From: Valdis.Kletnieks@vt.edu
References: <c0iqrq$erh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-965451060P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Feb 2004 11:01:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-965451060P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Feb 2004 16:29:28 +0100, =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>  said:
> Hi,
> 
> "getpcaps 1" shows, that the init-process is started without 
> cap_setpcap, and i know that i can change that somehow.
> So why are capabilities disabled? and how do i enable them?
> 
> If capabilities aren't still too unmature, wouldn't it be fine to have 
> an option in "make menuconfig" to enable them?

There was a long thread back in October 2003 labeled:

Subject: Re: posix capabilities inheritance

http://marc.theaimsgroup.com/?l=linux-kernel&m=106673587410831&w=2

that discusses the biggest issues.  Basically, we can get it right, or
we can follow Posix.  Andy Lutomirski at Stanford seemed to know what needed
doing, but I don't know if any actual changes were applied to the baseline
source tree.

--==_Exmh_-965451060P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFALPTScC3lWbTT17ARAnREAJ9nCr2weLAIvxbhBhO5E2D8mbbgngCfb5Ds
3jITGQJYV+my3ioznXo6Bfw=
=Sq9t
-----END PGP SIGNATURE-----

--==_Exmh_-965451060P--
