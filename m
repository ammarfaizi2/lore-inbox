Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282999AbRLCIvz>; Mon, 3 Dec 2001 03:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283003AbRLCItG>; Mon, 3 Dec 2001 03:49:06 -0500
Received: from ns.suse.de ([213.95.15.193]:56074 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281820AbRLBVjG>;
	Sun, 2 Dec 2001 16:39:06 -0500
Date: Sun, 2 Dec 2001 22:39:05 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <3C0A9BD7.47473324@zip.com.au>
Message-ID: <Pine.LNX.4.33.0112022236150.26183-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, Andrew Morton wrote:

> > Really?  So then people should be designing for 128 CPU machines, right?
> Linux only supports 99 CPUs.  At 100, "ksoftirqd_CPU100" overflows
> task_struct.comm[].
> Just thought I'd sneak in that helpful observation.

Wasn't someone looking at fixing that problem so it didn't need a per-cpu
thread ? 128 kernel threads sitting around waiting for a problem that
rarely happens seems a little.. strange. (for want of a better word).

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

