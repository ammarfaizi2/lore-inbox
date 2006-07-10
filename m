Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbWGJSAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWGJSAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWGJSAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:00:53 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:20641 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965156AbWGJSAw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:00:52 -0400
Message-Id: <200607101759.k6AHxbda012403@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Automatic Kernel Bug Report
In-Reply-To: Your message of "Mon, 10 Jul 2006 12:40:07 CDT."
             <e1e1d5f40607101040u3baf0da7r43d5538700b02e2@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com> <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com> <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com> <20060709125805.GF13938@stusta.de> <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com> <20060709191107.GN13938@stusta.de> <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com> <200607092019.k69KJt66005527@turing-police.cc.vt.edu> <e1e1d5f40607091327y3db1cbdco89ebdb04cda60ce0@mail.gmail.com> <20060710081131.GA2251@elf.ucw.cz>
            <e1e1d5f40607101040u3baf0da7r43d5538700b02e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152554377_3170P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 13:59:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152554377_3170P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Jul 2006 12:40:07 CDT, Daniel Bonekeeper said:

> real bugs. If so, they get reported here on LKML. Since we can expect,
> maybe, dozens of thousands of reports per week, wouldn't be hard to
> distinct between real bugs, etc (if we use frequency as a marker).

Actually, at that level, it *is* hard to distinguish.  I'm sure the RedHat
people have a *very* good idea of exactly how much PEBKAC cruft their bugzilla
gathers - and that's from users clued enough to bugzilla.

It might be interesting to use it to measure how many machines crap out because
of stray single-bit errors due to insufficient ECC on the hardware.

You can't use "a sudden upsurge" in reports as a good regression test, because
the vast majority of boxes are running distro kernels.  RHEL 4.0 just shipped a
2.6.9-34 kernel.  Ubuntu is on a 2.6.15.

And the people who are using kernel.org kernels aren't actually upgrading all
*that* fast either.  You'll get better info by looking at the lkml postings
that say '2.6.mumble regressed my foobar' - that will likely trigger before any
statistical tendency in bug reports gets noticed.

(Visit the bugzilla.mozilla.org, and note that neither 'most frequently
reported' nor 'reported today' give you a really good grasp on *current*
issues....)

--==_Exmh_1152554377_3170P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEspWJcC3lWbTT17ARAhNWAKDLKbwiBv3Ts1qY8cCReOojFPAUIwCg/Wcc
69SuBP/kXVlXeuuzKPt3MVI=
=Z+RD
-----END PGP SIGNATURE-----

--==_Exmh_1152554377_3170P--
