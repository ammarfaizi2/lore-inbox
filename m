Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318881AbSG1BxN>; Sat, 27 Jul 2002 21:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318882AbSG1BxM>; Sat, 27 Jul 2002 21:53:12 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:53259 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318881AbSG1BxM>; Sat, 27 Jul 2002 21:53:12 -0400
Date: Sat, 27 Jul 2002 22:56:08 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Robert Love <rml@tech9.net>,
       Russell Lewis <spamhole-2001-07-16@deming-os.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
In-Reply-To: <20020728014813.GH2907@holomorphy.com>
Message-ID: <Pine.LNX.4.44L.0207272254090.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002, William Lee Irwin III wrote:

> Feasible database workloads on 32-bit machines running mainline kernels
> seem to run with between 50% and 90% of physical memory consumed by
> process pagetables and severe restrictions on the number of clients
> that attempt to connect. When larger proportions of memory are consumed
> by process pagetables, kernel deadlock often ensues.

Even with 50% of memory in pagetables, I wouldn't be happy.

If I fork out the money for a machine with 16 GB of RAM, I'd
expect the thing to be able to at least cache 12 GB of my
database.  Wasting all of memory in page tables just isn't
allright ;)

Gerrit told me some people within IBM are working on large
page support for shared memory segments and mmap()d areas,
I hope it'll be good enough to get accepted into 2.5 soon...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

