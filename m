Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUHJKHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUHJKHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUHJKHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:07:39 -0400
Received: from pop.gmx.de ([213.165.64.20]:65454 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263795AbUHJKHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:07:37 -0400
X-Authenticated: #4512188
Message-ID: <41189E61.2000302@gmx.de>
Date: Tue, 10 Aug 2004 12:07:29 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: David Woodhouse <dwmw2@infradead.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <1092082920.5761.266.camel@cube> <1092124796.1438.3695.camel@imladris.demon.co.uk> <20040810095223.GJ10361@merlin.emma.line.org>
In-Reply-To: <20040810095223.GJ10361@merlin.emma.line.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matthias Andree wrote:
|>That seems reasonable, but _only_ if burnfree is not enabled. If the
|>hardware _supports_ burnfree but it's disabled, the warning should also
|>recommend turning it on.
|
|
| burnfree causes a few broken pits/lands on the CD-R so it is best
| avoided if the hardware can do it. That you don't see these is a matter
| of the reading drive not exporting such information and EFM and CIRC
| usually correcting them, but it's still lower quality than a burn
| process that hadn't needed burnfree at all.

Some addition: Even if your statement is correct, the data read is not
different, as C1 error correction should mask it. Yes, the quality
obviosly is lower, but most probably you won't notice it, unless the
disk degrades with time/scratches and now more errors appear, so it
isn't correctable anymore. But I think it is paranoic to rather have
coasters than living with a bit less quality at some spots where buffer
underruns occured.

Prakash


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGJ5hxU2n/+9+t5gRAtDtAKCnOgqG+6PobYDcDuNxdA6zdjPQwACgxjxL
Vy0KwpXHoMixCIvKeuxsZP0=
=WEtE
-----END PGP SIGNATURE-----
