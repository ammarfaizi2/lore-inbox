Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVCCDmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVCCDmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVCCB5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:57:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4037 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261370AbVCCBge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:36:34 -0500
Date: Wed, 2 Mar 2005 18:02:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [request for inclusion] Filesystem in Userspace
Message-ID: <20050302210201.GC4100@logos.cnet>
References: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu> <20050302123123.3d528d05.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302123123.3d528d05.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

On Wed, Mar 02, 2005 at 12:31:23PM -0800, Andrew Morton wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Do you have any objections to merging FUSE in mainline kernel?
> 
> I was planning on sending FUSE into Linus in a week or two.  That and
> cpusets are the notable features which are 2.6.12 candidates.
> 
> - crashdump seems permanently not-quite-ready
> 
> - perfctr works fine, but is rather deadlocked because it is
>   similar-to-but-different-from ia64's perfmon, and might not be suitable
>   for ppc64 (although things have gone quiet on the latter front).

I once asked Mikael about using PMC's from kernel-space, he told me it wouldnt
be too hard to make them usable via kernel-space through perfctr.

Is perfmon's API useable to kernel users? 

That sounds like a good point in favour of a given implementation, no?
