Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVD2IXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVD2IXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 04:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVD2IXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 04:23:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:49281 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262263AbVD2IXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 04:23:42 -0400
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, David Addison <addy@quadrics.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
In-Reply-To: <1114535584.5410.2.camel@mindpipe>
References: <426E62ED.5090803@quadrics.com>
	 <Pine.LNX.4.62.0504261829110.2071@dragon.hyggekrogen.localhost>
	 <1114535584.5410.2.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 18:22:01 +1000
Message-Id: <1114762921.7182.287.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 13:13 -0400, Lee Revell wrote:
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

Not exactly. I used the 2-lines style for a while, and changed overtime
and now can't stand anything but the one line style  :)

I recommend you read the mailing list archives for linus comments on
this issue btw.

Ben.


