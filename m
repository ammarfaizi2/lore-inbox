Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286005AbRLTDjz>; Wed, 19 Dec 2001 22:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286004AbRLTDjo>; Wed, 19 Dec 2001 22:39:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42764 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285994AbRLTDjf>; Wed, 19 Dec 2001 22:39:35 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gcc 3.0.2/kernel details (-O issue)
Date: 19 Dec 2001 19:39:25 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vrmhd$mf9$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10112192037490.3265-100000@luxik.cdi.cz> <1008792213.806.36.camel@phantasy> <20011220001006.GA18071@arthur.ubicom.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011220001006.GA18071@arthur.ubicom.tudelft.nl>
By author:    Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
In newsgroup: linux.dev.kernel
> 
> It doesn't change syntax, but anything lower than -O1 simply doesn't
> inline functions with an "inline" attribute. The result is that the
> inline functions in header files won't get inlined and the compiler
> will complain about missing functions at link time (or module insert
> time).
> 
> I'm actually surprised that 2.2 can be compiled with -O, AFAIK
> linux-2.2 also has a lot of inline functions in headers. I know from
> experience that -Os works for 2.4 kernels on ARM, I haven't tested it
> with 2.2 or x86.
> 

-O is -O1.  If you turn on the optimizer at all you get inlining.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
