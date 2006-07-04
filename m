Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWGECZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWGECZw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 22:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWGECZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 22:25:52 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49600 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932318AbWGECZv (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 22:25:51 -0400
Message-Id: <200607042223.k64MNLcQ004923@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: john stultz <johnstul@us.ibm.com>
Cc: Daniel Walker <dwalker@mvista.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Mon, 03 Jul 2006 12:59:43 PDT."
             <1151956783.5325.8.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271212150.17704@scrub.home> <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271903320.12900@scrub.home> <Pine.LNX.4.64.0606271919450.17704@scrub.home> <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu> <1151453231.24656.49.camel@cog.beaverton.ibm.com> <Pine.LNX.4.64.0606281218130.12900@scrub.home> <Pine.LNX.4.64.0606281335380.17704@scrub.home> <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu> <1151695569.5375.22.camel@localhost.localdomain> <200606302104.k5UL41vs004400@turing-police.cc.vt.edu> <Pine.LNX.4.64.0607030256581.17704@scrub.home> <1151891783.5922.4.camel@c-67-180-134-207.hsd1.ca.comcast.net>
            <1151956783.5325.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152051708_4949P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 18:21:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152051708_4949P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Jul 2006 12:59:43 PDT, john stultz said:
> On Sun, 2006-07-02 at 18:56 -0700, Daniel Walker wrote:
> > On Mon, 2006-07-03 at 03:13 +0200, Roman Zippel wrote:
> > I was reviewing these new ntp adjustment functions, and it seems like it
> > would be a lot easier to just switch to a better clocksource. These new
> > functions seems to compensate for a clock that has a high rating but is
> > actually quite poor..
> 
> Not quite. The issue is that the adjustment that the ntpd makes is quite
> fine grained, and some clocksources while quite stable, might not be
> able to make such a fine adjustment. So the extra error accounting just
> allows us to keep track and compensate for the resolution differences.
> 
> Does that make sense?

Except for the fact that NTP isn't running yet when I see this trouble...

--==_Exmh_1152051708_4949P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqun8cC3lWbTT17ARAr5mAJ9qguwPvpiBiOcNrU35QU/9EoRgEQCePe++
2nLFtSw2xUNXZbOJgMnxixk=
=7BGo
-----END PGP SIGNATURE-----

--==_Exmh_1152051708_4949P--
