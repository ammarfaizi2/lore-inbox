Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263342AbTJVBGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 21:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTJVBGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 21:06:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49412 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263342AbTJVBGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 21:06:34 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] frandom - fast random generator module
Date: 21 Oct 2003 18:06:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bn4l5q$v73$1@cesium.transmeta.com>
References: <3F8E552B.3010507@users.sf.net> <bn40oa$i4q$1@gatekeeper.tmr.com> <bn46q9$1rv$1@cesium.transmeta.com> <bn4aov$jf7$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <bn4aov$jf7$1@gatekeeper.tmr.com>
By author:    davidsen@tmr.com (bill davidsen)
In newsgroup: linux.dev.kernel
> | 
> | Bullshit.  "myrng 36 | foo" works just fine.
> 
> myrng?? That doesn't seem to be part of the bash I have, or any
> distribution I could check, and google shows a bunch of visual basic
> results rather than anything useful.
> 
> If you're suggesting that every user write their own program to
> generate random numbers, then write a script to call it, that kind of
> defeats the purpose of doing shell instead of writing a program, doesn't
> it? Not to mention that to get entropy the user program will have to
> call the devices anyway.
> 
> I think this could also fail the objective of returning unique results
> in an SMP system, but that's clearly imprementation dependent.
> 

No, I mean that putting a piece of code in the kernel "so it can be
accessed from shell scripts" is idiotic.  Make a binary of it and put
it in the filesystem.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
