Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbTCTXkK>; Thu, 20 Mar 2003 18:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbTCTXkJ>; Thu, 20 Mar 2003 18:40:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15888 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262663AbTCTXj1>; Thu, 20 Mar 2003 18:39:27 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Deprecating .gz format on kernel.org
Date: 20 Mar 2003 15:50:10 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b5dk3i$mc6$1@cesium.transmeta.com>
References: <200303202154.h2KLsDcT009516@marc2.theaimsgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200303202154.h2KLsDcT009516@marc2.theaimsgroup.com>
By author:    Hank Leininger <linux-kernel@progressive-comp.com>
In newsgroup: linux.dev.kernel
>
> On 2003-03-20, Joern Engel <joern () wohnheim ! fh-wedel ! de> wrote:
> > On Thu, 20 March 2003 17:39:20 +0000, Jamie Lokier wrote:
> > > (b) On something as large as a .tar, decompressing a bz2 file to
> > > check the signature is really quite slow, compared with checking the
> > > signature of the compressed file.
> 
> > That shouldn't matter, most of the times. If you want to build the
> > code, you have to [bg]unzip anyway, so there is no extra cost.
> > And I have a hard time to think of a real-world application where you
> > don't want to unpack but need to verify the signature.
> 

Just to finish this debate: I have added support for generating .sign
files from .gz files, and those are currently being generated, but I
will not remove .gz.sign or .bz2.sign files.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
