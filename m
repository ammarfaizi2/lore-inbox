Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUGFUIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUGFUIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUGFUIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:08:40 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:4862 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262927AbUGFUIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:08:37 -0400
Message-ID: <40EB06BF.208@comcast.net>
Date: Tue, 06 Jul 2004 16:08:31 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Redeeman <lkml@metanurb.dk>
CC: Erik Mouw <erik@harddisk-recovery.com>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: quite big breakthrough in the BAD network performance, which
 mm6 did not fix
References: <1089070720.14870.6.camel@localhost>	 <200407051754.38690.lkml@lpbproductions.com>	 <1089120330.10626.8.camel@localhost>	 <20040706135303.GG20237@harddisk-recovery.com> <1089128977.10626.11.camel@localhost>
In-Reply-To: <1089128977.10626.11.camel@localhost>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Please follow these instructions:

1.  STFU
2.  Log in as root
3.  emerge apache
4.  Set up a local web server with a large file on it
5.  wget -c the file over your network with each kernel, from another
computer on the local network.

Erik's said several times now to use a local server.  He's right.
You're not.  Probability is against him; but you're still in the box
with schrodinger's cat, so you can't give any sort of guarantee either.
~ His method *does* give a controlled experiment which supplies said
guarantee.

Redeeman wrote:
| On Tue, 2004-07-06 at 15:53 +0200, Erik Mouw wrote:
|
|>On Tue, Jul 06, 2004 at 03:25:30PM +0200, Redeeman wrote:
|>
|>>i am aware of this, however, what i use to benchmark is kernel.org, as i
|>>can see they have alot bandwith free.
|>>if i use kernel.org http i get 50kb/s, if i use ftp, i can easily fetch
|>>with 200kb/s
|>
|>That could be easily explained by the fact that the www.kernel.org ftp
|>and http services are handled by different programs (vsftpd vs.
|>Apache).
|
| yeah it could.. however it isnt. because 2.6.5 can easily take 200kb/s
| from kernel.org http, and it sound strange too, that with 2.6.7 ALL http
| adresses only give 50kb/s, and with 2.6.5 it gives 200 :>
|
|>
|>Erik
|>
|
|
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
|
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA6wa9hDd4aOud5P8RAm1/AJ4i+9BY9x00QaRZKbB/jBSCV9AbHgCdG7bj
23bKs8ptiLOA32B816Y13vk=
=1oBo
-----END PGP SIGNATURE-----
