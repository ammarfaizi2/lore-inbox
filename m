Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbUKQNPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbUKQNPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbUKQNOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:14:09 -0500
Received: from cantor.suse.de ([195.135.220.2]:5064 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262303AbUKQNLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:11:45 -0500
Date: Wed, 17 Nov 2004 13:08:19 +0100
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dropped patch: mm/mempolicy.c:sp_lookup()
Message-ID: <20041117120819.GG4620@wotan.suse.de>
References: <200411162259_MC3-1-8ED8-6C32@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411162259_MC3-1-8ED8-6C32@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 10:54:09PM -0500, Chuck Ebbert wrote:
> On Wed, 17 Nov 2004 at 02:00:20 +0100, Andi Kleen wrote:
> 
> > On Mon, Nov 15, 2004 at 11:15:51PM -0500, Chuck Ebbert wrote:
> > > Andrea posted this one-liner a while ago as part of a larger patch.  He said
> > > it fixed return of the wrong policy in some conditions.  Was this a valid fix?
> >
> > Yes it was.
> 
>   At least it wasn't dropped -- it's in -mm as part of
> fix-for-mpol-mm-corruption-on-tmpfs, though it's unrelated to tmpfs.
> (That patch contains three separate changes...)
> 
>   Should just this part, which changes '<' to '<=', be pushed upstream?

Yes. I'm sure Andrea will take care of that himself. 

-Andi
