Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVCUW6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVCUW6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVCUW4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:56:36 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:64780 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261977AbVCUWyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:54:05 -0500
Message-ID: <423F507B.1090009@tuxrocks.com>
Date: Mon, 21 Mar 2005 15:53:47 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: LKML <linux-kernel@vger.kernel.org>, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 0/5] I8K driver facelift
References: <200502240110.16521.dtor_core@ameritech.net> <200503170140.49328.dtor_core@ameritech.net> <423951E3.6070804@tuxrocks.com> <200503210012.29477.dtor_core@ameritech.net>
In-Reply-To: <200503210012.29477.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
> I have implemented arrays of groups of attributes:

Works great here.  The i8k-cumulative patch claimed to be malformed, but
I merged it in just fine by hand.  In arch/i386/kernel/dmi_scan.c, I had
to EXPORT dmi_get_system_info in order to get the i8k module to load.
That may have been a mistake on my end (lots of odd patches in my tree
right now).  I'm a little curious to see how many people are going to
find they need the ignore_dmi flag versus working without it.

Everything works great, and it is a big step up from the existing code.
 I say lets go with it.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCP1B7aI0dwg4A47wRAufNAJ9tJODed2rcndtytGCZbJHr5AQJPgCgqbA1
zWnRrePRdJ/+5K1yu5HM3jg=
=OzaL
-----END PGP SIGNATURE-----
