Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267448AbTBIVNE>; Sun, 9 Feb 2003 16:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbTBIVNE>; Sun, 9 Feb 2003 16:13:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6669 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267448AbTBIVNE>; Sun, 9 Feb 2003 16:13:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Cyrix III processor and kernel boot problem
Date: 9 Feb 2003 13:22:16 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b26gq8$ks1$1@cesium.transmeta.com>
References: <3E43C79A.2010506@autistici.org> <1044631346.14350.17.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1044631346.14350.17.camel@irongate.swansea.linux.org.uk>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> On Fri, 2003-02-07 at 14:50, c1cc10 wrote:
> > I've found out that the Cyrix III has no CMOV instruction and that this 
> > could be the problem.
> 
> It is
> 
> gcc told to build for i686 assumes that cmov is present. Much of the 
> code advantage for i686 comes from cmov so it makes sense to do that
> I guess.
> 

Yep.  The other name for the option, -mach=pentiumpro, really is the
more proper name.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
