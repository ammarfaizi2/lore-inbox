Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUKNUFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUKNUFb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUKNUDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:03:38 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:52461 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261348AbUKNUCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:02:43 -0500
Message-ID: <4197B9D9.9010806@g-house.de>
Date: Sun, 14 Nov 2004 21:02:33 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
References: <200411122248_MC3-1-8E97-BFE5@compuserve.com> <20041113142835.GA9109@lists.us.dell.com> <20041114025814.GA20342@lists.us.dell.com>
In-Reply-To: <20041114025814.GA20342@lists.us.dell.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

sorry, took me a bit longer to get to the testing.


Matt Domsch schrieb:
> 
> Not ready for Linus yet, and you'll need to re-apply the previous
> edd.S patch which is now reverted in Linus's tree.  As your BIOS

i've applied the patch to a pristine 2.6.10-rc1, so the (currently
reverted) EDD change is still there. tell me, if the patch had to be
applied to sth. else.

but for now i have to say, that it still oopses:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.10-rc1_edd-2.txt

...
BIOS EDD facility v0.16 2004-Jun-25, 16 devices found
...

(oh, i've added an ide-disk yesterday, so hde will show up in dmesg.)

sorry,
Christian.
- --
BOFH excuse #401:

Sales staff sold a product we don't offer.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBl7nZ+A7rjkF8z0wRAvuHAKCX8TWiDt5DP25OqBEWKecfM6x3HwCeNRoM
1IzHqKpcbWOABXWJ4vC4d1w=
=FiKX
-----END PGP SIGNATURE-----
