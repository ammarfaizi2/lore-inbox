Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWGGFDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWGGFDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 01:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWGGFDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 01:03:38 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49110 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751058AbWGGFDh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 01:03:37 -0400
Message-Id: <200607070502.k6752IqY007285@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@stusta.de>, kai@germaschewski.name,
       linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
In-Reply-To: Your message of "Fri, 07 Jul 2006 05:36:30 +0200."
             <20060707033630.GA15967@mars.ravnborg.org>
From: Valdis.Kletnieks@vt.edu
References: <20060706163728.GN26941@stusta.de>
            <20060707033630.GA15967@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152248538_3190P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 01:02:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152248538_3190P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Jul 2006 05:36:30 +0200, Sam Ravnborg said:
> On Thu, Jul 06, 2006 at 06:37:28PM +0200, Adrian Bunk wrote:
> > With -Werror-implicit-function-declaration we are getting an immediate
> > compile error instead.
> This patch broke (-rc1):
...
> I did not try other architectures. We need to fix the allnoconfig cases
> at least for the popular architectures before applying this patch
> otherwise it will create too much trouble/noise.

What source files did it break on, and with what error message?  And is
there a reason to focus on 'allnoconfig', or do the other canned config
targets (allyes, allmod, rand, and so on) matter too?


--==_Exmh_1152248538_3190P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEreracC3lWbTT17ARAo0AAKDbAN9nlNZyGsxjYwgc5bB4EqnT0wCg6nxB
GUXpBYHYgNaymEjSnkXMK0c=
=zpXj
-----END PGP SIGNATURE-----

--==_Exmh_1152248538_3190P--
