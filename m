Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbTBCWFW>; Mon, 3 Feb 2003 17:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTBCWFW>; Mon, 3 Feb 2003 17:05:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18697 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266564AbTBCWFV>; Mon, 3 Feb 2003 17:05:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: CPU throttling??
Date: 3 Feb 2003 14:14:23 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b1mpjv$mfq$1@cesium.transmeta.com>
References: <F760B14C9561B941B89469F59BA3A84725A14A@orsmsx401.jf.intel.com> <20030203211806.GA21312@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030203211806.GA21312@codemonkey.org.uk>
By author:    Dave Jones <davej@codemonkey.org.uk>
In newsgroup: linux.dev.kernel
> 
> Most (all?[1]) other modern x86 mobile processors behave the way I mentioned.
> AMD Powernow (K6 and K7), VIA longhaul/powersaver all have optimal voltages
> they can be run at when clocked to different speeds. By way of example, a table from
> my mobile athlon..
> 
>     FID: 0x12 (4.0x [532MHz])   VID: 0x13 (1.200V)
>     FID: 0x4 (5.0x [665MHz])    VID: 0x13 (1.200V)
>     FID: 0x6 (6.0x [798MHz])    VID: 0x13 (1.200V)
>     FID: 0xa (8.0x [1064MHz])   VID: 0xd (1.350V)
>     FID: 0xf (10.5x [1396MHz])  VID: 0x9 (1.550V)
> 
> Sure I *could* run that at 523MHz and still pump 1.550V into it,
> but why would I want to do that ?
> 
> 		Dave
> 
> [1] Unsure about the crusoe.
> 

Crusoe changes frequency and voltages on the fly, transparently to the
operating system.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
