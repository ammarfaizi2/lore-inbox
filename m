Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbTCEOyo>; Wed, 5 Mar 2003 09:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbTCEOyo>; Wed, 5 Mar 2003 09:54:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8979 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266771AbTCEOyn>; Wed, 5 Mar 2003 09:54:43 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Reserving physical memory at boot time
Date: 5 Mar 2003 07:04:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b453mj$qpi$1@cesium.transmeta.com>
References: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com> <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net> <b442s0$pau$1@cesium.transmeta.com> <32981.4.64.238.61.1046844111.squirrel@www.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <32981.4.64.238.61.1046844111.squirrel@www.osdl.org>
By author:    "Randy.Dunlap" <rddunlap@osdl.org>
In newsgroup: linux.dev.kernel
> 
> OK, with feeling:
> 
> I agree with you since the boot protocol is well-defined.
> 
> Just to be clear, my comment was referring to
> Documentation/kernel-parameters.txt, not to any C code.
> 
> And it would really be helpful to catch issues like this soon
> after they happen...
> 

Unfortunately last time I commented on this the response was roughly
"well, the patch already made it into Linus' kernel, it's too late to
fix it now."  That isn't exactly a very helpful response.

The mem= parameter has the semantic in the i386/PC boot protocol that
it specifies the top address of the usable memory region that begins
at 0x100000.  It's a bit of a wart that the boot loaders have to be
aware of this, but it's so and it's been so for a very long time.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
