Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUJZQGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUJZQGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 12:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbUJZQGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 12:06:00 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:7671 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261322AbUJZQBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 12:01:36 -0400
Message-ID: <417E74DD.6000203@comcast.net>
Date: Tue, 26 Oct 2004 12:01:33 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
References: <7aaed09104102213032c0d7415@mail.gmail.com> <7aaed09104102214521e90c27c@mail.gmail.com>
In-Reply-To: <7aaed09104102214521e90c27c@mail.gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Espen Fjellvær Olsen wrote:
| This may come a bit late now, since the "new development model" was
| put through late this summer.
| But anyway i'm going to come with som thoughts about it.
|
| I think that 2.6 should be frozen from now on, just security related
| stuff should be merged.
| This would strengthen Linux's reputation as a stable and secure
| system, not a unstable and a system just used for fun.
| A 2.7 should be created where all new experimental stuff is merged
| into it, and where people could begin to think new again.
| New thoughts are good in all ways, it is for sure very much code in
| the current kernels that should be revised, rewritten and maybe marked
| as deprecated.
|
| :)

I agree fully.

I've been quite worried and annoyed.  While I do think the newest
releases and the changes in 2.6.9 and .10 are damn cool, and i want
them, I also won't let go of PaX.  PaX stopped at 2.6.7 because of
internal VM changes; the kernel's unstable state is making it an undue
amount of work for the PaX team to update PaX for the newest kernels.
If all the time is spent porting it up to the new VM changes, then there
is no time for bugfixes and improvements.

PaX is a core component of GrSecurity as well; as long as the PaX
project is halted at 2.6.7, GrSec can't pass 2.6.7.  How many other
projects are going to sit at 2.6.7, or are going to spend too much time
up-porting and not enough time bugfixing and enhancing?

I do not propose freezing *now* if it's not convenient; I say you pick
what you want to finish up (maybe some of the Montavista stuff; I'd
personally like voluntary pre-empt and friends at least), get that in,
and slate any new developments for a 2.6.7 branch to be forked off
whenever is appropriate.

|
| --
| Mvh / Best regards
| Espen Fjellvær Olsen
| espenfjo@gmail.com
| Norway
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfnTdhDd4aOud5P8RAlsMAJ9ppwugKHeXm9pjDePNyRuQ9mTvZACfXwNR
Tj930yU5hMJFrbj27ez3lWQ=
=XEVU
-----END PGP SIGNATURE-----
