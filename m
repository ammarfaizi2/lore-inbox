Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265730AbSJTBpF>; Sat, 19 Oct 2002 21:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265731AbSJTBpF>; Sat, 19 Oct 2002 21:45:05 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:37847 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265730AbSJTBpE>; Sat, 19 Oct 2002 21:45:04 -0400
Date: Sat, 19 Oct 2002 23:50:37 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jeff Dike <jdike@karaya.com>
cc: Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, andrea <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0 
In-Reply-To: <200210190450.XAA06161@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44L.0210192349220.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Jeff Dike wrote:

> My preferred solution would be for libc to ask the kernel where the
> vsyscall area is.  That's reasonably clean and virtualizable.  Andrea
> doesn't like it because it adds a few instructions to the vsyscall
> address calculation.

Sounds like the best solution indeed, especially when keeping
in mind the strange people who want to run with a different
user:kernel split or statically linked binaries at fun addresses
so they've got more space for their fortran arrays ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

