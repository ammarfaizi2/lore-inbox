Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbSJHV77>; Tue, 8 Oct 2002 17:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSJHV77>; Tue, 8 Oct 2002 17:59:59 -0400
Received: from thunk.org ([140.239.227.29]:63171 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261341AbSJHV7L>;
	Tue, 8 Oct 2002 17:59:11 -0400
Date: Tue, 8 Oct 2002 18:04:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chuck Lever <cel@citi.umich.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] better RPC statistics
Message-ID: <20021008220450.GC9807@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Chuck Lever <cel@citi.umich.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NFS List <nfs@lists.sourceforge.net>
References: <Pine.LNX.4.44.0210081517370.1273-100000@dexter.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210081517370.1273-100000@dexter.citi.umich.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 03:20:07PM -0400, Chuck Lever wrote:
> hi Linus-
> 
> this is the only patch i have that probably should be in 2.5 before 
> October 20.  the rest i will save until things calm down.
> 
> this patch, against 2.5.41, adds some new statistics in the RPC layer.  
> these are similar to stats kept in reference client implementations, and 
> are designed to help sysadmins track down NFS client issues more quickly.
> since this changes a "kernel interface" it should go in now.

It's not just "kernel interfaces" which should go in before October
20th.  

If we really want the feature freeze to be real, we really will need
to be hard-nosed about what we accept after the freeze date.  (Said he
who is frantically trying to finish up a last couple of ext2/3
features in before 2.6.)

So I'd encourage folks to at least submit patches before Oct. 20th
when they are ready, and not try to save stuff for after feature
freeze....

						- Ted
