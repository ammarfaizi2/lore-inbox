Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132605AbQLHUIF>; Fri, 8 Dec 2000 15:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132603AbQLHUHz>; Fri, 8 Dec 2000 15:07:55 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:8182 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S132393AbQLHUHq>; Fri, 8 Dec 2000 15:07:46 -0500
Date: Fri, 8 Dec 2000 11:36:20 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Peter Samuelson <peter@cadcamlab.org>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Rainer Mager <rmager@vgkk.com>, linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <20001207200415.O6567@cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0012081128330.24557-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Peter Samuelson wrote:

> 
> [Dick Johnson]
> > Do:
> > 
> > char main[]={0xff,0xff,0xff,0xff};
> 
> Oh come on, at least pick an *interesting* invalid opcode:
> 
>   char main[]={0xf0,0x0f,0xc0,0xc8};	/* try also on NT (: */

What's funny, is that this actually executes on SPARC hardware, but
immediately segfaults. On Intel hardware though, you get a message similar
to:

zsh: illegal hardware instruction (core dumped)  a.out

I wrote relatively the same program in college. It exploits the F0 0F bug
found in early Pentium hardware.

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
