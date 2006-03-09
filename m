Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751921AbWCIPL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWCIPL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 10:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWCIPL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 10:11:28 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:1473 "EHLO pilet.ens-lyon.fr")
	by vger.kernel.org with ESMTP id S1751921AbWCIPL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 10:11:27 -0500
Date: Thu, 9 Mar 2006 16:11:29 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3
Message-ID: <20060309151129.GB24034@ens-lyon.fr>
References: <20060307021929.754329c9.akpm@osdl.org> <20060309061535.GC19403@ens-lyon.fr> <20060309144451.GA24034@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309144451.GA24034@ens-lyon.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to cc:lkml, sorry

On Thu, Mar 09, 2006 at 03:44:51PM +0100, Benoit Boissinot wrote:
> On Thu, Mar 09, 2006 at 07:15:35AM +0100, Benoit Boissinot wrote:
> > On Tue, Mar 07, 2006 at 02:19:29AM -0800, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/
> > > 
> > > - A relatively small number of changes, although we're up to 9MB of diff
> > >   in the various git trees.
> > > 
> > 
> > I just encountered a memleak, this is a laptop and i use swsusp (I am not
> > sure if it is related but since the memleak involves task_struct).
> 
> After one night, i have in slabinfo:
> task_struct          342    342   1344    3    1 : tunables   24   12 0 : slabdata    114    114      0
> 
> whereas ps Haux | wc -l gives 56.
> 
> Is it possible that some kernel thread does not get deallocated
> correctly ?
> 
> regards,
> 
> Benoit
> -- 
> powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
