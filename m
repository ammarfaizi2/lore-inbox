Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVBITOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVBITOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 14:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVBITOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 14:14:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:31132 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261707AbVBITO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 14:14:27 -0500
Date: Wed, 9 Feb 2005 11:14:15 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [patch, BK] clean up and unify asm-*/resource.h files
Message-ID: <20050209111415.I469@build.pdx.osdl.net>
References: <20050209093927.GA9726@elte.hu> <20050210020333.7941fa6e.sfr@canb.auug.org.au> <20050209180219.GC23554@elte.hu> <20050209105622.Z24171@build.pdx.osdl.net> <20050209190546.GA25753@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050209190546.GA25753@elte.hu>; from mingo@elte.hu on Wed, Feb 09, 2005 at 08:05:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Chris Wright <chrisw@osdl.org> wrote:
> 
> > * Ingo Molnar (mingo@elte.hu) wrote:
> > > this patch does the final consolidation of asm-*/resource.h file,
> > > without changing any of the rlimit definitions on any architecture.
> > > Primarily it removes the __ARCH_RLIMIT_ORDER method and replaces it with
> > > a more compact and isolated one that allows architectures to define only
> > > the offending rlimits.
> > 
> > Heh, I did it this way first, then worried people might find it
> > confusing to only have a subset of the block overwritten I backed it
> > down to the __ARCH_RLIMIT_ORDER method.  Anyway, I like this change.
> > 
> > Acked-by: Chris Wright <chrisw@osdl.org>
> 
> the original reason i ended up doing this was when i introduced a new
> rlimit and it needed changes in 5 include files. Now the new rlimit is
> off the agenda but the cleanup remained :-)

Hehehe, that's the same reason I did the last one ;-)

cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
