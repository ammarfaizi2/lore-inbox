Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbSLITcG>; Mon, 9 Dec 2002 14:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbSLITcG>; Mon, 9 Dec 2002 14:32:06 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:20370 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265998AbSLITcG>;
	Mon, 9 Dec 2002 14:32:06 -0500
Date: Mon, 9 Dec 2002 19:36:49 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021209193649.GC10316@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <200212090830.gB98USW05593@flux.loup.net> <at2l1t$g5n$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at2l1t$g5n$1@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 05:48:45PM +0000, Linus Torvalds wrote:

 > P4's really suck at system calls.  A 2.8GHz P4 does a simple system call
 > a lot _slower_ than a 500MHz PIII. 
 > 
 > The P4 has problems with some other things too, but the "int + iret"
 > instruction combination is absolutely the worst I've seen.  A 1.2GHz
 > Athlon will be 5-10 times faster than the fastest P4 on system call
 > overhead. 

Time to look into an alternative like SYSCALL perhaps ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
