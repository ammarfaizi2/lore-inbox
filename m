Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbSJaDEE>; Wed, 30 Oct 2002 22:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265138AbSJaDEE>; Wed, 30 Oct 2002 22:04:04 -0500
Received: from nameservices.net ([208.234.25.16]:6064 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265135AbSJaDED>;
	Wed, 30 Oct 2002 22:04:03 -0500
Message-ID: <3DC0A01B.15B8B535@opersys.com>
Date: Wed, 30 Oct 2002 22:14:35 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> > Linux Trace Toolkit (LTT)
> 
> I don't know what this buys us.

How about being able to:
- Debug synchronization problems among processes (there is no other
tool to do this, not gdb, not strace, not printf, ...)
- Measure exact time spent wainting for kernel and which other
processes a process had to wait for.
- Measure exact time it takes for an interrupt's effects to propagate
throughout the entire system.
- Understand the exact behavior the system has to input. (what is
the exact sequence of processes that run when I press a key).
- Identify sporadic problems in very saturated systems. (thousands
of servers and one of them is doing weird stuff).
- etc.

Providing system tracing is a necessity for any sort of complex
application development and system monitoring. Some people simply
can't use Linux without this sort of tool and I am at pains to
explain to them why they actually have to patch their kernel to
be able to debug their inter-process synchronization problems.

Users don't have to patch their kernel to use gdb and I don't
see why they should need to patch their kernel to understand how
their various processes interact with the kernel and vice-versa.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
