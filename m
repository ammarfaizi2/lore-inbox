Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUHJKEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUHJKEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUHJKEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:04:42 -0400
Received: from imap.gmx.net ([213.165.64.20]:28909 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263820AbUHJKD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:03:29 -0400
X-Authenticated: #4512188
Message-ID: <41189D67.2090104@gmx.de>
Date: Tue, 10 Aug 2004 12:03:19 +0200
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
|

Well shouldn't that broken pits just happen, wehn the buffer gets empty
and the laser continues where it stopped after having data in buffer
again? I guess this is better then a coaster.

BTW, I don't have problems burning as a user while doing other things...

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGJ1nxU2n/+9+t5gRAjljAKCbjbxNX47d7//QDkQNP/e8OMB5aACfXFDa
Z3CorT523TXskw4YEBMRaDk=
=cpq7
-----END PGP SIGNATURE-----
