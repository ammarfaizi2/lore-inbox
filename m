Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288991AbSAZCjq>; Fri, 25 Jan 2002 21:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288994AbSAZCjm>; Fri, 25 Jan 2002 21:39:42 -0500
Received: from ns.suse.de ([213.95.15.193]:7429 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288991AbSAZCjZ>;
	Fri, 25 Jan 2002 21:39:25 -0500
Date: Sat, 26 Jan 2002 03:39:24 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <20020126032655.A13340@wotan.suse.de>
Message-ID: <Pine.LNX.4.33.0201260338370.688-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jan 2002, Andi Kleen wrote:

> The real fix for that would be support of SYSENTER/SYSCALL on 32bit too
> (more likely SYSENTER because it's supported by Athlons and SYSCALL is too
> broken on K6 to be usable)

There's an implementation at http://fy.chalmers.se/~appro/linux/sysenter.c
Haven't looked at it long enough to see how good/bad it is..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

