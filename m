Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310339AbSCGOE7>; Thu, 7 Mar 2002 09:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310338AbSCGOEu>; Thu, 7 Mar 2002 09:04:50 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:36873 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310335AbSCGOEh>;
	Thu, 7 Mar 2002 09:04:37 -0500
Date: Thu, 7 Mar 2002 07:04:42 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Dike <jdike@karaya.com>,
        Benjamin LaHaise <bcrl@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020307070442.A26987@hq.fsmlabs.com>
In-Reply-To: <E16iyGp-0002IL-00@the-village.bc.nu> <E16iy41-00037z-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16iy41-00037z-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Mar 07, 2002 at 02:36:08PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 02:36:08PM +0100, Daniel Phillips wrote:
> On March 7, 2002 02:49 pm, Alan Cox wrote:
> > Jeff Dike Apparently wrote
> > > caller.  This is actually wrong because in this failure case, it effectively
> > > changes the semantics of GFP_USER, GFP_KERNEL, and the other blocking GFP_* 
> > > allocations to GFP_ATOMIC.  And that's what forced UML to segfault the 
> > > compilations.
> > 
> > GFP_KERNEL will sometimes return NULL.
> 
> Sad but true.  IMHO we are on track to fix that in this kernel cycle, with
> better locked/dirty accounting and rmap to forcibly unmap pages when necessary.

Why is that a fix? And how can it work?


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

