Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316239AbSEKRhh>; Sat, 11 May 2002 13:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316240AbSEKRhg>; Sat, 11 May 2002 13:37:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57865 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316239AbSEKRhg>; Sat, 11 May 2002 13:37:36 -0400
Date: Sat, 11 May 2002 10:37:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Russell King <rmk@arm.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2
In-Reply-To: <3CDD5570.E7E97205@mvista.com>
Message-ID: <Pine.LNX.4.44.0205111034400.2355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 May 2002, george anzinger wrote:
>
> So, what to do?  For ARM and MIPS we could go back to solution 1:

Why not just put that knowledge in the ARM/MIPS architecture makefile?

ARM already has multiple linker scripts, and it already selects on them
based on CONFIG options, so I'd much rather just do that straightforward
kind of thing than play any clever games.

MIPS runs some sed script on it and that could be expanded to do this, and
all the same arguments apply.

		Linus

