Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268252AbTBYTuS>; Tue, 25 Feb 2003 14:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268256AbTBYTuS>; Tue, 25 Feb 2003 14:50:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8723 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268252AbTBYTuR>; Tue, 25 Feb 2003 14:50:17 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Date: 25 Feb 2003 12:00:14 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b3gi0e$g2i$1@cesium.transmeta.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030225092520.A9257@flint.arm.linux.org.uk>
By author:    Russell King <rmk@arm.linux.org.uk>
In newsgroup: linux.dev.kernel
>
> On Tue, Feb 25, 2003 at 07:28:46AM +0100, Mikael Starvik wrote:
> > >I don't know linker scripts very well.
> > >Can this be done for all architectures?
> > >I'd like to see a solution that is arch-independent.
> > 
> > In embedded systems it is probably not desirable to keep 
> > System.map and config in zImage (takes too much valuable space).
> 
> Agreed - zImage is already around 1MB on many ARM machines, and since
> loading zImage over a serial port using xmodem takes long enough
> already, this is one silly feature I'll definitely keep out of the
> ARM tree.
> 

Isn't that what "strip" is for?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
