Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbSLUWDG>; Sat, 21 Dec 2002 17:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSLUWDG>; Sat, 21 Dec 2002 17:03:06 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:3506 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S265093AbSLUWC4>; Sat, 21 Dec 2002 17:02:56 -0500
Date: Sat, 21 Dec 2002 23:10:56 +0100 (CET)
From: <folkert@vanheusden.com>
To: John Bradford <john@grabjohn.com>
cc: Ro0tSiEgE <lkml@ro0tsiege.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel GCC Optimizations
In-Reply-To: <200212211811.gBLIBeX9000864@darkstar.example.net>
Message-ID: <Pine.LNX.4.33.0212212307460.24398-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there any risk using -O3 instead of -O2 to compile the kernel, and why?
> * It might uncover subtle bugs that would otherwise not occur.

I wonder: for the sake of performance and good use of the precious clock-
cycles, shouldn't there be made a start of fixing those bugs? Assuming
that the bugs you're talking about are not compiler-bugs, they *are* bugs
in the code that should be fixed, shouldn't they?

> * Compiling with unusual options means that less people will know about
> any problems it causes you.

So, let's make it -O6 per default for 2.7.x/3.1.x?


Folkert
www.vanheusden.com/Linux

