Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316686AbSGQUg7>; Wed, 17 Jul 2002 16:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSGQUg6>; Wed, 17 Jul 2002 16:36:58 -0400
Received: from daimi.au.dk ([130.225.16.1]:32191 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316686AbSGQUgQ>;
	Wed, 17 Jul 2002 16:36:16 -0400
Message-ID: <3D35D5E2.1D1DBE41@daimi.au.dk>
Date: Wed, 17 Jul 2002 22:38:58 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@stny.rr.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reserve memory from the command line
References: <Pine.LNX.4.44.0207171307380.29293-100000@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> 
> Hi,
> 
> Today I just discoved that my Toshiba laptop has a small bit of bad
> memory.  So I went on looking for a way to reserve the memory area from
> the command line, because I run several kernels for various reasons and
> that it would be easiest to just modify lilo.conf.
> 
> After seaching the web and scanning the source code I realize that there
> are only patches to do this and not in the vanilla kernel.  I was
> wondering why such a usefull feature is not in the kernel?
> 
> I'm using kernel versions 2.4.7 to 2.4.18 and didn't want to go patching
> each one.  I'll probably just hardcode the bad memory as reserved and be
> done with it.
> 
> Is this feature planned on becoming part of the kernel, at least as a
> config option, and if not, then why not?
> 
> If it is already there, and I missed it, please let me know.

I couldn't find it in the Documentation directory, but there
is a comment about it in linux/arch/i386/kernel/setup.c

                /*
                 * "mem=nopentium" disables the 4MB page tables.
                 * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
                 * to <mem>, overriding the bios size.
                 * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
                 * <start> to <start>+<mem>, overriding the bios size.
                 */

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
