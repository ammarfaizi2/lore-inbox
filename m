Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284356AbRLCIvw>; Mon, 3 Dec 2001 03:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284362AbRLCItd>; Mon, 3 Dec 2001 03:49:33 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:19211 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282975AbRLBWLA>; Sun, 2 Dec 2001 17:11:00 -0500
Message-ID: <3C0AA6D6.30BE0BF6@zip.com.au>
Date: Sun, 02 Dec 2001 14:10:30 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <3C0A9BD7.47473324@zip.com.au> <Pine.LNX.4.33.0112022236150.26183-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Sun, 2 Dec 2001, Andrew Morton wrote:
> 
> > > Really?  So then people should be designing for 128 CPU machines, right?
> > Linux only supports 99 CPUs.  At 100, "ksoftirqd_CPU100" overflows
> > task_struct.comm[].
> > Just thought I'd sneak in that helpful observation.
> 
> Wasn't someone looking at fixing that problem so it didn't need a per-cpu
> thread ?

Not to my knowledge.

> 128 kernel threads sitting around waiting for a problem that
> rarely happens seems a little.. strange. (for want of a better word).

I've kinda lost the plot on ksoftirqd.  Never really understood
why a thread was needed for this, nor why it runs at nice +20.
But things seem to be working now.

-
