Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbTCSAcE>; Tue, 18 Mar 2003 19:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262839AbTCSAcE>; Tue, 18 Mar 2003 19:32:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45318 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262826AbTCSAcD>; Tue, 18 Mar 2003 19:32:03 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
 due to wrmsr (performance)
Date: 18 Mar 2003 16:42:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b58edl$au1$1@cesium.transmeta.com>
References: <3E7765DE.10609@didntduck.org> <Pine.LNX.4.44.0303181113590.13708-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0303181113590.13708-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> Wow. There aren't many things that AMD tends to show the P4-like "big
> latency in rare cases" behaviour.
> 
> But quite honestly, I think they made the right call, and I _expect_ that
> of modern CPU's. The fact is, modern CPU's tend to need to pre-decode the
> instruction stream some way, and storing to it while running from it is
> just a really really bad idea. And since it's so easy to avoid it, you
> really just shouldn't do it.
> 

AMD, I believe, has an "annotated" icache.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
