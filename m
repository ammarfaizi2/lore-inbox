Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316630AbSEQR5X>; Fri, 17 May 2002 13:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSEQR5W>; Fri, 17 May 2002 13:57:22 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52741 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316630AbSEQR5V>; Fri, 17 May 2002 13:57:21 -0400
Date: Fri, 17 May 2002 13:53:10 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Andrew Morton <akpm@zip.com.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug with shared memory.
In-Reply-To: <20020515154200.B8975@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.3.96.1020517135011.15351A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Mike Kravetz wrote:


> It appears that this was done for 'sparc64', but no other architectures.
> I would consider doing this for i386, if anyone would actually use it.
> 
> One would think these types of things are easily found, but this example
> suggests otherwise.  Has anyone run the kernel through an extensive
> (stress) test suite with any of the kernel debug options enabled?

Does this imply that the option:
  CONFIG_DEBUG_SPINLOCK=y
doesn't work on x86? Or works poorly? I'm not sure what changes you're
proposing, but if they will make this more robust I'll certainly use them!
SMP lockups are the bane of my existance, although
19-pre8-ac4+preempt+iowait has yet to take that route.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

