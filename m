Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261388AbSIZPhw>; Thu, 26 Sep 2002 11:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbSIZPhw>; Thu, 26 Sep 2002 11:37:52 -0400
Received: from thunk.org ([140.239.227.29]:23712 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261388AbSIZPhv>;
	Thu, 26 Sep 2002 11:37:51 -0400
Date: Thu, 26 Sep 2002 11:42:17 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020926154217.GA10551@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209252223.13758.ryan@completely.kicks-ass.org> <20020926055755.GA5612@think.thunk.org> <200209260041.59855.ryan@completely.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209260041.59855.ryan@completely.kicks-ass.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 12:41:54AM -0700, Ryan Cumming wrote:
> On September 25, 2002 22:57, Theodore Ts'o wrote:
> > On Wed, Sep 25, 2002 at 10:23:11PM -0700, Ryan Cumming wrote:
> > > It seems to be running stable now. Linux 2.4.19, UP Athlon, GCC 3.2.
> >
> > Just to humor me, can you try it with gcc 2.95.4?  I just want to
> > eliminate one variable....
> 
> Using GCC 2.95.4 seems to stabilize dir_index nicely, both before and after 
> the hdparm -fD run. Only the kernel was recompiled with 2.95.4, I reused the 
> original GCC 3.2 compiled e2fsprogs.

Hmm... I just tried biult 2.4.19 with the ext3 patch on my UP P3
machine, using GCC 3.2, and I wasn't able to replicate your problem.
(This was using Debian's gcc 3.2.1-0pre2 release from testing.)

What was the precise GCC 3.2 version you were using, and for what
architecture were you compiling for?  As I recall P3 kernels should
run on Athlons, if memory serves me correctly.  (I don't have any
Athlons at home, so if it's an Athlon-specific code generation bug,
I'll have problems replicating it.)  Could you try compiling a kernel
for the P3 architecture using GCC 3.2, and see whether or not the
problem is there?  This is just a shot in the dark, but....

						- Ted

