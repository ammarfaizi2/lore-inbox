Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUHCONo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUHCONo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUHCONo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:13:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:25568 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266481AbUHCONj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:13:39 -0400
X-Authenticated: #4512188
Message-ID: <410F9D94.8050302@gmx.de>
Date: Tue, 03 Aug 2004 16:13:40 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040710)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Barry K. Nathan" <barryn@pobox.com>,
       Steve Snyder <swsnyder@insightbb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
References: <200408021602.34320.swsnyder@insightbb.com> <20040802220521.GA2179@ip68-4-98-123.oc.oc.cox.net> <20040803133034.GM23504@suse.de>
In-Reply-To: <20040803133034.GM23504@suse.de>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jens Axboe wrote:
| On Mon, Aug 02 2004, Barry K. Nathan wrote:
|
|>On Mon, Aug 02, 2004 at 04:02:34PM -0500, Steve Snyder wrote:
|>
|>>There seems to be a controversy about the use of the CONFIG_HIGHMEM4G
|>>kernel configuration.  After reading many posts on the subject, I still
|>>don't know which setting is best for me.
|>
|>On my own desktop system with 1GB RAM, any highmem slowdown seems to be
|>outweighed by the fact that more disk data stays cached in RAM (so I hit
|>the disk much less often).
|
|
| There's also the option of moving the mapping only slightly, so that all
| of the 1G fits in low memory. That's the best option for 1G desktop
| machines, imho. Changing PAGE_OFFSET from 0xc0000000 to 0xb0000000 would
| probably be enough.
|
| Then you can have your cake and eat it too.

This works nicely for me. I wonder why this doesn't become standard
behaviour in kernel. At least a lot of people would be happy about it.

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBD52UxU2n/+9+t5gRArjwAKDhLKcV2C42O++Eqd7yFOQoURtoxgCgyt/m
5dDyjJtoF7WDzelrGzk7MGM=
=fdFY
-----END PGP SIGNATURE-----
