Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVCDFDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVCDFDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVCDFDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:03:14 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:40870 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S262433AbVCDEg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 23:36:26 -0500
Message-ID: <4227E5B9.1090303@tequila.co.jp>
Date: Fri, 04 Mar 2005 13:36:09 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/03/2005 07:21 AM, Linus Torvalds wrote:

> Comments?

before you do this, we have to make -rc's real rc's. Seriously how can
it be that there is a diff between the last rc and the "vanilla"
release. Thats a no-goer in my opinion. Even if it is small things,
there is a chance that it breaks. If there patches that have to be
applied, because they are bugfixes, then make another rc before going live.

And odd/even sub number won't help here anyway. People who get the
kernel won't know it, there will be confusion, etc.

I would stick with the current scheme, I see no big advantage in a
special odd/even numbering. If there is a bugfix release, call it
X.Y.Z.1 like for 2.6.8, rest of the bugfixing can be found in -ac/-as
patchsets anyway.

The time of using vanilla kernels is long over. Nowadays its more like,
something, where you wait that a vendor gives you a kernel, or else you
will shot your own foot off ...

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCJ+W4jBz/yQjBxz8RAgnoAKCKGVcIujulCLyk8p3ole80RhhcOwCgyHSM
tD2sZv+sCz7oG5MfokKh05c=
=lnqT
-----END PGP SIGNATURE-----
