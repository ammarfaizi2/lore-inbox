Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289105AbSAUJeh>; Mon, 21 Jan 2002 04:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289106AbSAUJe1>; Mon, 21 Jan 2002 04:34:27 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:40644 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289105AbSAUJeQ>; Mon, 21 Jan 2002 04:34:16 -0500
Message-Id: <200201210934.g0L9Y7qV001830@tigger.cs.uni-dortmund.de>
To: Andrew Morton <akpm@zip.com.au>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: Message from Andrew Morton <akpm@zip.com.au> 
   of "Sun, 20 Jan 2002 17:30:12 PST." <3C4B6F24.C2750F51@zip.com.au> 
Date: Mon, 21 Jan 2002 10:34:07 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> said:
> "Mr. James W. Laferriere" wrote:
> >         This is just what the Heads are trying to do away with .  There
> >         will only be module enabled kernels .  JimL

> I suspect none of these "Heads" spend much time in protracted
> email debug sessions.  Because the *first* thing you do is
> ask the tester to compile the relevant driver into the
> kernel.
> 
> The problems which the removal of this option will cause include:
> 
> 1: Inability to look up symbols in the kernel elf image.

ksymoops(8) is able to find them...

> 2: Breaks the kernel profiler

Which one?

> 3: breaks kgdb

Officially not wanted by the heads, so irrelevant

> 4: breaks ksymoops.

How so?
-- 
Horst von Brand			     http://counter.li.org # 22616
