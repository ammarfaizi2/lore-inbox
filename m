Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263958AbSJWJzF>; Wed, 23 Oct 2002 05:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSJWJzF>; Wed, 23 Oct 2002 05:55:05 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:15280 "EHLO
	pc.kolivas.net") by vger.kernel.org with ESMTP id <S263958AbSJWJzE>;
	Wed, 23 Oct 2002 05:55:04 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.44-mm3
Date: Wed, 23 Oct 2002 20:01:00 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210232001.08647.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Problem

I run hdparm in my init (to disable apm on the hard drive routinely) and got 
this when I tried to boot mm3:

CPU:0
EIP 0060:[<c01b630e>] Not tainted
EFLAGS: 00010286
eax: 00000000 ebx: cdf73f00 ecx: cd4b0cd4 edx: c02479c4
esi: cdf73f00 edi: c02479cf ebp: 00000000 esp: cd4bbefc
ds: 0068 es: 0068 ss: 0068
Process hdparm (pid: 315, threadinfo=cd4ba000 tsk=cd938ce0)
Stack: cdf73f00 c013b3dc cd4b0cd4 cdab6540 cd4b0cd4 cdab6540 ffffffe9 cdfe65e0
	cdf73f20 00000000 00000000 160065e0 ffffffa 00000000 c013b65e cdf73f00
	cd4b0cd4 cdab6540 cd4b0cd4 cdab6540 cd4b0cd4 c0134d7a cd4b0cd4 cdab6540
Call Trace: [<c013b3dc>] [<c013b65e>] [<c0134d7a>] [<c0134cb2>] [<c0135023>]
[<c0106cd3>]
Code: 8b 40 2c 8b 5c 24 0c 8b 90 e8 00 00 00 ff 80 54 01 00 00 50


Then when I try to use the keyboard each keystroke produces something like:
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value, 0

The machine still works ok after this but I keep getting this with each 
keystroke.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9tnNfF6dfvkL3i1gRAtICAKCS4jwiqEdS/A8kUivzny6tn6549wCeIXZr
wcpKVUGAPbSGCq0HplGfOUA=
=8/+L
-----END PGP SIGNATURE-----
