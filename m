Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSLQS52>; Tue, 17 Dec 2002 13:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSLQS52>; Tue, 17 Dec 2002 13:57:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19716 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265409AbSLQS50>; Tue, 17 Dec 2002 13:57:26 -0500
Date: Tue, 17 Dec 2002 11:05:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Dike <jdike@karaya.com>
cc: Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance 
In-Reply-To: <200212171839.NAA08357@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0212171105000.1095-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Jeff Dike wrote:
>
> torvalds@transmeta.com said:
> > That also allows the kernel to move around the SYSINFO page at will,
> > and even makes it possible to avoid it altogether (ie this will solve
> > the inevitable problems with UML - UML just wouldn't set AT_SYSINFO,
> > so user level just wouldn't even _try_ to use it).
>
> Why shouldn't I just set it to where UML provides its own SYSINFO page?

Sure, that works fine too.

		Linus

