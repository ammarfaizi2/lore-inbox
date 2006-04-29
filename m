Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWD2HTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWD2HTu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 03:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWD2HTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 03:19:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:38836 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750958AbWD2HTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 03:19:50 -0400
Date: Sat, 29 Apr 2006 00:18:18 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] catch valid mem range at onlining memory
Message-ID: <20060429071818.GA939@kroah.com>
References: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com> <20060428163409.389e895e.akpm@osdl.org> <20060428234410.GA7598@kroah.com> <20060428170519.1194b077.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428170519.1194b077.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 05:05:19PM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > > This all looks fairly (but trivially) dependent upon the 64-bit-resource
> > > patches in Greg's tree.  Greg, were you planning on merging them in the
> > > post-2.6.17 flood?
> > 
> > Yes, I was,
> 
> OK, thanks.
> 
> > unless there are any objections to me doing this?
> 
> I'd consider the patches as they stand to be ready to roll.
> 
> All the code bloat's a bit sad though.  It would have been nice to have
> made the type of resource.start and .end Kconfigurable.  What happened
> to that?

Hm, I didn't remember anything about that.  Vivek, any thoughts?

thanks,

greg k-h
