Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUFXSAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUFXSAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUFXSAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:00:45 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:30593 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266820AbUFXSAe (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:00:34 -0400
Message-Id: <200406241800.i5OI0km9026151@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2 
In-Reply-To: Your message of "Thu, 24 Jun 2004 17:04:30 +0200."
             <Pine.LNX.4.58.0406241701460.10292@scrub.local> 
From: Valdis.Kletnieks@vt.edu
References: <20040624014655.5d2a4bfb.akpm@osdl.org> <40DAD511.A19CEFB7@users.sourceforge.net>
            <Pine.LNX.4.58.0406241701460.10292@scrub.local>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_998937004P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Jun 2004 14:00:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_998937004P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Jun 2004 17:04:30 +0200, Roman Zippel said:
> Hi,
> 
> On Thu, 24 Jun 2004, Jari Ruusu wrote:
> 
> > This breaks existing recommended syntax for external modules, because the
> > mini Makefile in object directory always provides O= even in cases where
> > calling code specified its own object directory:
> > 
> >     make -C /lib/modules/`uname -r`/build modules M=`pwd` O=/foo
> 
> Where is this recommended? How do you know that "/foo" is better directory 
> on a random system?

I think Jari's point is that it's providing O=/something *even* when the
calling code *DOES* know that /foo is a better directory, so when you pass it
O=/foo because you know it's The Right Thing for Your Particular Random System,
it gets overridden.

Either that, or I need to find more caffeine, and re-parse what Jari wrote... ;)

--==_Exmh_998937004P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA2xbOcC3lWbTT17ARApT9AKCYN0w1axoz63evHzpjvPj5yufFPACgoFZU
oQ2KJwygcyfLlTt1MhYlkm8=
=DK+i
-----END PGP SIGNATURE-----

--==_Exmh_998937004P--
