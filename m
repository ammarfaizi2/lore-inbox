Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286495AbSABBLb>; Tue, 1 Jan 2002 20:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286468AbSABBLW>; Tue, 1 Jan 2002 20:11:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24070 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286491AbSABBLJ>; Tue, 1 Jan 2002 20:11:09 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: a great C++ book?
Date: 1 Jan 2002 17:10:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a0tmmt$ear$1@cesium.transmeta.com>
In-Reply-To: <20020101041111.29695.qmail@web14310.mail.yahoo.com> <Pine.LNX.4.43.0201011214560.7188-100000@waste.org> <20020101104331.F4802@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020101104331.F4802@work.bitmover.com>
By author:    Larry McVoy <lm@bitmover.com>
In newsgroup: linux.dev.kernel
> 
> Makes you wonder what would happen if someone tried to design a
> minimalistic C++, call it the "M programming language", have be close
> to C with the minimal useful parts of C++ included.
> 

Personally I have found that it's quite clean and easy to program in 
"C+" by simply using a C++ compiler and just not going wild with all
the features that you *could* use.  You don't *have* to use all of it,
you know.  In that way, your "M" language really becomes a particular
*style* of C++ rather than a full-blown programming language in its
own right.  This is actually a Good Thing[TM], since it means you can
leverage existing compilers and so forth.

Way back in the 0.99.x days we actually tried doing the Linux kernel
using the g++ compiler, the main motivation for that was to get
type-safe linkage.  At that time, as everyone knows, g++ wasn't up to
snuff; that has probably changed now.  The LKML FAQ claims that "there
would be no point" unless we started using C++ features left and
right; personally I think type-safe linkage is plenty of reason
enough.

I think it might be worth another attempt once gcc 3.x stabilizes
enough that it's the accepted standard compiler.  It will be more
invasive this time around, because of the module system, but the
benefit might be greater.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
