Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSCGCZn>; Wed, 6 Mar 2002 21:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290713AbSCGCZY>; Wed, 6 Mar 2002 21:25:24 -0500
Received: from ns0.auctionwatch.com ([66.7.130.2]:65029 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S290587AbSCGCZO>; Wed, 6 Mar 2002 21:25:14 -0500
Date: Wed, 6 Mar 2002 18:25:07 -0800
From: Petro <petro@auctionwatch.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Probable Memory/VM issue.
Message-ID: <20020307022507.GE32504@auctionwatch.com>
In-Reply-To: <20020306054143.GN22934@auctionwatch.com> <E16ikLn-00004q-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16ikLn-00004q-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 10:57:35PM +0000, Alan Cox wrote:
> > Bogus stack limit or frame pointer, fp=0xbfabf8c0, stack_bottom=0xbfc7fcb8, thread_stack=65536, aborting backtrace.
> > Trying to get some variables.
> > Some pointers may be invalid and cause the dump to abort...
> > thd->query at (nil)  is invalid pointer
> > thd->thread_id=20479119
> Which says nothing alas - nothing about user or kernel space. If the system
> had run out of memory and killed it you'd have seen "killed" and an OOM
> entry logged

    It definately did not run out of memory--we monitor that pretty
    close, and the memory usage was pretty constant for the 90+ hours
    prior to the crash. 

-- 
Share and Enjoy. 
