Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUFMWO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUFMWO1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 18:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUFMWO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 18:14:27 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:4300 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261231AbUFMWOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 18:14:25 -0400
Message-ID: <40CCD1BD.6090509@g-house.de>
Date: Mon, 14 Jun 2004 00:14:21 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schmidt <andy@space.wh1.tu-dresden.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Frequent system freezes after kernel bug
References: <20040612183742.GE1733@rocket> <20040612202023.GA22145@taniwha.stupidest.org> <20040612214947.GI1733@rocket> <40CB9B84.4030502@g-house.de> <20040613175134.GO1733@rocket>
In-Reply-To: <20040613175134.GO1733@rocket>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas Schmidt wrote:
| _did_ happen again. So, what do you suggest? (Sorry if that sounds
| obnoxious, but I'm really a bit confused about this stuff...)

sorry to confuse. no, i'm not able to tell any relevant information from
your oops. i must say that it just occured *to me* that we had different
oopses and lockups with fcdsl and fcpci (!) modules, which were hard to
reproduce too.

you said:
| This box runs under Debian stable; I noticed these particular bugs
| starting with kernel 2.4.24. Yesterday, I updated from 2.4.25 to

so 2.4.23 did work? would be strange, since patch-2.4.24.b2 is only
2,5KB in size and touches very few things. good for you: if 2.4.23 is
really working and 2.4.24 is not, you could back out the changes and see
what it gives.

just my 2¢,
Christian.
- --
BOFH excuse #179:

multicasts on broken packets
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAzNG8+A7rjkF8z0wRAo4XAJ9wP6X38jyICqmB7ATYSyc2N6l/BgCfQnVf
TkJlP1NWnExS6uub5KEHesk=
=DoAL
-----END PGP SIGNATURE-----
