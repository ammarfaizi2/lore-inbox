Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTCEFeU>; Wed, 5 Mar 2003 00:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTCEFeU>; Wed, 5 Mar 2003 00:34:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16143 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261302AbTCEFeT>; Wed, 5 Mar 2003 00:34:19 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Reserving physical memory at boot time
Date: 4 Mar 2003 21:44:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b442s0$pau$1@cesium.transmeta.com>
References: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com> <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net>
By author:    "Randy.Dunlap" <rddunlap@osdl.org>
In newsgroup: linux.dev.kernel
> 
> Patch for 'mem=exactmap' in 2.4 was submitted several weeks ago and
> Alan merged it into -ac.  It does need to be pushed to Marcelo...
> 

Once again, with feeling...

DON'T CALL IT mem=.

mem= is part of the boot protocol.
Call it memmap= or something, or you'll break boot loaders in weird
and subtle ways.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
