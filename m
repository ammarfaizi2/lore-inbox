Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUBRM5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUBRM5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:57:45 -0500
Received: from s199-007.catv.glattnet.ch ([80.242.199.7]:16772 "EHLO
	hathi.ethgen.de") by vger.kernel.org with ESMTP id S266846AbUBRM5l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:57:41 -0500
Date: Wed, 18 Feb 2004 13:57:31 +0100
From: Klaus Ethgen <Klaus@Ethgen.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [KERNEL] Re: [KERNEL] Re: TCP: Treason uncloaked DoS ??
Message-ID: <20040218125731.GB11303@hathi.ethgen.de>
References: <20040218102725.GB3394@hathi.ethgen.de> <20040218105508.GA7320@dingdong.cryptoapps.com> <20040218124141.GA11303@hathi.ethgen.de> <20040218124859.GA8382@dingdong.cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <20040218124859.GA8382@dingdong.cryptoapps.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Hello,

Am Mi den 18. Feb 2004 um 13:48 schriebst Du:
> So you have a packetshaper then?  By this I mean a PacketShaper from
> packeteer (http://packeteer.com/prod-sol/products/packetshaper.cfm).

No, only the kernel own htb shaper. And it is on the other interface.

> I can't see how, but I don't know your setup and/or config. to

Me too. But this exactely is my problem.

> If there is a PacketShaper near the machine, I'm going to suggest
> taking that away and see if this message goes away.  If it's upstream
> of course you can't do this.

After this tip that it could be tu do with the TC on the other interface
I will try this out this night.

Regards
   Klaus
- -- 
Klaus Ethgen                            http://www.ethgen.de/
pub  2048R/D1A4EDE5 2000-02-26 Klaus Ethgen <Klaus@Ethgen.de>
Fingerprint: D7 67 71 C4 99 A6 D4 FE  EA 40 30 57 3C 88 26 2B
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQDNhO5+OKpjRpO3lAQHw3QgAkJKfGdcLVGzUJEGBX0kOSCdufb/yxDXt
Y5/V2t4RkWN9wwnRc58u/Ga/S7acUeK7vMOLTyioLY2DI12JXOKugfTsGPnm7qmc
qgpVnZ0u0exsUJZHgtbe9ezW3Yot0U7yQv+VDidT28ieGMj1PrY8p0D0zc2hnMU8
iJcmoHeThK4JCw25Uu0jxTfx/LE5XIjp23LRwKJY3UOmjH4MQpJbJH2Sz7uycfX8
V4NXzK+t2LiCX01jT/diuRcvEZ95IkOxrspuy0OHd9L7Gi4dWYDVueLwBSM6apBO
B4AEKWrzzzkqKLxgiWh64fXq/wqWi3rvdR0hu/w8TG+QDBEcltOPog==
=7JRR
-----END PGP SIGNATURE-----
