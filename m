Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316251AbSEKSOU>; Sat, 11 May 2002 14:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316252AbSEKSOT>; Sat, 11 May 2002 14:14:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55300 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316251AbSEKSOS>; Sat, 11 May 2002 14:14:18 -0400
Date: Sat, 11 May 2002 19:11:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george anzinger <george@mvista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2
Message-ID: <20020511191118.F1574@flint.arm.linux.org.uk>
In-Reply-To: <3CDD5570.E7E97205@mvista.com> <Pine.LNX.4.44.0205111034400.2355-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 10:37:39AM -0700, Linus Torvalds wrote:
> On Sat, 11 May 2002, george anzinger wrote:
> >
> > So, what to do?  For ARM and MIPS we could go back to solution 1:
> 
> Why not just put that knowledge in the ARM/MIPS architecture makefile?
> 
> ARM already has multiple linker scripts, and it already selects on them
> based on CONFIG options, so I'd much rather just do that straightforward
> kind of thing than play any clever games.

So would I - there will be a config option, so we can just use sed on the
relevant linker script to do the right thing.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

