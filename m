Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVD1Lel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVD1Lel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 07:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVD1Lel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 07:34:41 -0400
Received: from unthought.net ([212.97.129.88]:54935 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262060AbVD1Lef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 07:34:35 -0400
Date: Thu, 28 Apr 2005 13:34:34 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, David Addison <addy@quadrics.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
Message-ID: <20050428113434.GD17359@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Lee Revell <rlrevell@joe-job.com>, Jesper Juhl <juhl-lkml@dif.dk>,
	David Addison <addy@quadrics.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	David Addison <david.addison@quadrics.com>
References: <426E62ED.5090803@quadrics.com> <Pine.LNX.4.62.0504261829110.2071@dragon.hyggekrogen.localhost> <1114535584.5410.2.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114535584.5410.2.camel@mindpipe>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 01:13:04PM -0400, Lee Revell wrote:
> On Tue, 2005-04-26 at 18:57 +0200, Jesper Juhl wrote:
> > > 
> > > +static inline void
> > > +ioproc_release(struct mm_struct *mm)
> > > +{
> > 
> > Return types on same line as function name makes grep'ing a lot 
> > easier/nicer.
> > 
> > Here's the example from Documentation/CodingStyle : 
> > 
> >         int function(int x)
> >         {
> 
> How so?  I never understood the reasons.  This makes it easier to grep
> for everything that returns int.  But you make the common case (what
> file is function() defined in?) harder.

etags/ctags end of story :)

-- 

 / jakob

