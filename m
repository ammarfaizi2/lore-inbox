Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVJLVa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVJLVa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVJLVaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:30:25 -0400
Received: from fmr24.intel.com ([143.183.121.16]:46985 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932399AbVJLVaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:30:23 -0400
Date: Wed, 12 Oct 2005 14:30:08 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [discuss] Re: [Patch] x86, x86_64: Intel HT, Multi core detection code cleanup
Message-ID: <20051012143008.A29292@unix-os.sc.intel.com>
References: <20051005161706.B30098@unix-os.sc.intel.com> <20051007095200.GL6642@verdi.suse.de> <20051007175240.A2354@unix-os.sc.intel.com> <200510081228.39492.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200510081228.39492.ak@suse.de>; from ak@suse.de on Sat, Oct 08, 2005 at 12:28:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2005 at 12:28:38PM +0200, Andi Kleen wrote:
> On Saturday 08 October 2005 02:52, Siddha, Suresh B wrote:
> > On Fri, Oct 07, 2005 at 11:52:00AM +0200, Andi Kleen wrote:
> > > > I can fix the API mess. Is there anything else you want me to do?
> > >
> > > I think you overdid the sharing. Can you limit it to one file
> > > and copy the stuff that doesn't fit easily?
> >
> > Andi, This stuff is very much common to x86 and x86_64. Shared code is
> > split into two files because setting up sibling map code is generic and
> > HT/core detection code is very specific to Intel.
> >
> > How about the appended patch?
> 
> I would prefer if the Intel CPU detection support wasn't distributed over so 
> many small files. If you prefer to share it put it all into a single file and 
> share that. But please only for code that can be cleanly shared without 
> ifdefs.

Lets defer this code sharing to some other time. I want to make sure that 
-mm tree (and finally 2.6.15) picks up these enhancements first, before 
I start my vacation :)

> Also in general it would be better if you first did the cleanup and then 
> as separate patches the various functionality enhancements.That makes
> the changes easier to be reviewed and it helps in binary search when something 
> goes wrong.

I am going to send two follow up patches which addresses the functionality
enhancements.

thanks,
suresh
