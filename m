Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVBKAE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVBKAE6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 19:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVBKAE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 19:04:58 -0500
Received: from waste.org ([216.27.176.166]:58515 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261956AbVBKAEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 19:04:52 -0500
Date: Thu, 10 Feb 2005 16:04:25 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Jack O'Quin" <jack.oquin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com,
       Chris Wright <chrisw@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211000425.GC2474@waste.org>
References: <a075431a050210125145d51e8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a075431a050210125145d51e8c@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 02:51:44PM -0600, Jack O'Quin wrote:
> [direct reply bounced, resending via gmail]
> 
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Thu, Feb 10, 2005 at 02:35:08AM -0800, Andrew Morton wrote:
> > > > 
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm2/
> > > > 
> > > > 
> > > > - Added the mlock and !SCHED_OTHER Linux Security Module for the audio guys.
> > > >   It seems that nothing else is going to come along and this is completely
> > > >   encapsulated.
> > > 
> > > Even if we accept a module that grants capabilities to groups this
> > > isn't fine yet because it only supports two specific capabilities
> > > (and even those two in different ways!) instead of adding generic
> > > support to bind capabilities to groups.
> > 
> > I'm sure that got discussed somewhere in the 1000 emails which flew past
> > last time.  Jack?
> 
> [adding cc: for the main discussion participants]
> 
> Most people felt that a more general capabilities module would be nice
> to have.  But, no one offered any code, or volunteered to work on it.

What happened to the RT rlimit code from Chris?

-- 
Mathematics is the supreme nostalgia of our time.
