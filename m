Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTFOSYn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTFOSYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:24:42 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:11528 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262547AbTFOSYd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:24:33 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Bug 810] New: Kernel BUG at mm/slab.c:981
Date: Sun, 15 Jun 2003 20:38:02 +0200
User-Agent: KMail/1.5.2
References: <469250000.1055701220@[10.10.2.4]>
In-Reply-To: <469250000.1055701220@[10.10.2.4]>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306152038.02496.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 June 2003 20:20, Martin J. Bligh wrote:
>            Summary: Kernel BUG at mm/slab.c:981
>     Kernel Version: 2.5.70-71
>             Status: NEW
>           Severity: blocking
>              Owner: akpm@digeo.com
>          Submitter: s_aldinger@hotmail.com
>
>
> Since .69 I've been unable to boot. no config changes. I had to write this
> out and then type so if something looks really off it might be a typo, give
> a shout and I'll check it.
>
> Kernel BUG at mm/slab.c:981
> invalid operand:0000 [#1]
> cpu: 0
> EIP: 0060:[<c0136eca>]		Not tainted
> Eflags: 00010202
> eax: 000001a8		ebx:c053a5c0		ecx:c04ae990		edx:00001797
> esi:00000000 		edi:00000000		esp:c153ff6c
> ds:007b		es:007b		ss:0068
> Process swapper (pid: 1, threadinfo=c153e000 task=c151d880)
> Stack:	ffffe869	00000029 	0000000292	0000176b	00001797	c0546829
> 00000246	c011b51e	c053a5c0
> 00000000	00000000	00000000	c01d5046	c04464b8	000001a8	00000000
> 00000001
> c01d4ff2 		00000000 	c0527e9c	c0451f20		c053a5c0	c051cbbd
> 00000000
> Call Trace	[<c011b51e>]	[<c01d5046>]	[<c01d4ff2>]	[<c0527e9c>]
> [<c051c6bd>]	[<c0128542>]	[<c0105051>]	[<c010502c>]
> [<c010895d>]
> code: 0f 0b d5 03 60 28 44 c0 c7 44 24 04 d0 00 00 00 c7 04 24 e0
> <0> Kernel panic: Attempted to kill init!

Without ksymoops'ing it, IMHO it's rather useless. :)
- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 20:37:12 up  4:21,  2 users,  load average: 1.05, 1.03, 1.00

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+7L0KoxoigfggmSgRAmzsAJ9GY1iHazGXAxjms/zf84oMtKwy7wCdHsWV
0Y+QKGR5idPA1mvL+ZLFh8M=
=5uKV
-----END PGP SIGNATURE-----

