Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVASTJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVASTJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVASTJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:09:35 -0500
Received: from cantor.suse.de ([195.135.220.2]:21961 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261853AbVASTJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:09:28 -0500
Date: Wed, 19 Jan 2005 20:09:27 +0100
From: Andi Kleen <ak@suse.de>
To: Steve Longerbeam <stevel@mvista.com>
Cc: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG in shared_policy_replace() ?
Message-ID: <20050119190927.GM7445@wotan.suse.de>
References: <Pine.LNX.4.44.0501191221400.4795-100000@localhost.localdomain> <41EE9991.6090606@mvista.com> <20050119174506.GH7445@wotan.suse.de> <41EEA575.9040007@mvista.com> <20050119183430.GK7445@wotan.suse.de> <41EEAE04.3050505@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EEAE04.3050505@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 10:59:16AM -0800, Steve Longerbeam wrote:
> 
> Andi Kleen wrote:
> 
> >>yeah, 2.6.10 makes sense to me too. But I'm working in -mm2, and
> >>the new2 = NULL line is missing, hence my initial confusion. Trivial
> >>patch to -mm2 attached. Just want to make sure it has been, or will be,
> >>put back in.
> >>   
> >>
> >
> >That sounds weird. Can you figure out which patch in mm removes it?
> > 
> >
> 
> found it:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm1/broken-out/mempolicy-optimization.patch

Are you sure? I don't see it touching the new2 free at the end of the function.

-Andi
