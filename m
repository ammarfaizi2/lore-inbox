Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUDDRfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 13:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUDDRfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 13:35:16 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:35977 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261460AbUDDRfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 13:35:07 -0400
Message-ID: <40704743.3000909@g-house.de>
Date: Sun, 04 Apr 2004 19:34:59 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven Hartge <hartge@ds9.gnuu.de>
CC: linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
References: <20040329151515.GD2895@smtp.west.cox.net> <Pine.GSO.4.44.0403301430180.12030-100000@math.ut.ee> <E1B8OEW-0006Jb-BX@ds9.argh.org>
In-Reply-To: <E1B8OEW-0006Jb-BX@ds9.argh.org>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[ cc'ing linuxppc-dev ]

Sven Hartge wrote:
| Meelis Roos <mroos@linux.ee> wrote:
|
|
|>>Ok.  Can both of you try the following patch on top of the version
|>>which fails?
|
|
|>Tried it on top of fresh 2.6.5-rc3, no changes, it still hangs.
|
|
| Same here, still totally dead after tftp.

not so dead here. 2.6.4 is ok, 2.6.5-rc1|2|3 are loaded within the OF
menu, but no bootprompt appears. but: i can hear the scsi disk
initalizing, short after this, the atkbd is recognized and the LEDs on
my keyboard are flashing. then again my nfs-root is supposed to be
mounted, but my PReP still locks up completely upon network-init. (last
working is still 2.5.30).

another issue here: i was finally able to cross-compile 2.5.x / 2.6.x
kernels (on x86). i tried to compile kernels from 2.5.21 on with
"allnoconfig" (was introduced in 2.5.21). only 2.5.30 can be built, all
other attempts to build "zImage" fail...(still compiling 2.5.6x)...
(full logs of builds available...)

Christian.
- --
BOFH excuse #204:

Just pick up the phone and give modem connect sounds. "Well you said we
should get more lines so we don't have voice lines."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAcEdC+A7rjkF8z0wRAq5TAJsHIh5V7wb/IP1xW7uHde4nC3EquACgk4D+
TLrtSsdwpdtZBXCRmD9fiE4=
=aGiL
-----END PGP SIGNATURE-----
