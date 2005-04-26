Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVDZRWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVDZRWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVDZRWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:22:30 -0400
Received: from mail.dif.dk ([193.138.115.101]:31676 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261682AbVDZRQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:16:55 -0400
Date: Tue, 26 Apr 2005 19:20:13 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: David Addison <addy@quadrics.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
In-Reply-To: <1114535584.5410.2.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0504261918210.2071@dragon.hyggekrogen.localhost>
References: <426E62ED.5090803@quadrics.com> 
 <Pine.LNX.4.62.0504261829110.2071@dragon.hyggekrogen.localhost>
 <1114535584.5410.2.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Lee Revell wrote:

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
> 
I don't know what you do, but when I'm grep'ing the tree for some function 
I'm often looking for its return type, having that on the same line as the 
function name lets me grep for the function name and the grep output will 
contain the return type and function name nicely on the same line.

-- 
Jesper

