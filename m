Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTDGOwc (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbTDGOwc (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:52:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10508 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263479AbTDGOvE (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:51:04 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 64-bit kdev_t - just for playing
Date: 7 Apr 2003 08:02:14 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6s3tm$i2d$1@cesium.transmeta.com>
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304031256550.5042-100000@serv> <20030403133725.GA14027@win.tue.nl> <Pine.LNX.4.44.0304031548090.12110-100000@serv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0304031548090.12110-100000@serv>
By author:    Roman Zippel <zippel@linux-m68k.org>
In newsgroup: linux.dev.kernel
> 
> Yes, I know this mantra now and that's not the problem (or will be fixed 
> shortly).
> This still doesn't answer what will come next. You must have _some_ idea, 
> otherwise you wouldn't add a new interface, remove other infrastructure 
> and provide a patch which modifies MKDEV & co. All of this only leads us 
> away from the goal of dynamic device numbers. Why?
> 

I have an idea, why don't you read the archives of this mailing list
for the past eight years and learn, once again, why dynamic numbers
are broken for nearly all applications (disks and ptys being, perhaps,
the few case where they actually work.)

This has been hashed and rehashed on this list so many times it's not
even funny.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
