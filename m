Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSLUWFW>; Sat, 21 Dec 2002 17:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSLUWFV>; Sat, 21 Dec 2002 17:05:21 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S265270AbSLUWFV>; Sat, 21 Dec 2002 17:05:21 -0500
Date: Sat, 21 Dec 2002 23:13:22 +0100 (CET)
From: <folkert@vanheusden.com>
To: <axel@pearbough.net>
cc: Ro0tSiEgE <lkml@ro0tsiege.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel GCC Optimizations
In-Reply-To: <20021221180852.GA31293@neon.pearbough.net>
Message-ID: <Pine.LNX.4.33.0212212312070.24398-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there any risk using -O3 instead of -O2 to compile the kernel, and why?
> >  Also what about compiling against glibc 2.3.1 and gcc 3.2.x??
> I believe because of some assembler stuff that needs to be compiled as is and
> may not be optimized more that -O2 you cannot use -O3.

Then selective compile with -O2 or -O6? Like; everything with assembly in
it with -O2 and the rest with -O6.

Folkert
www.vanheusden.com/Linux

