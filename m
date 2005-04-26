Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVDZRNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVDZRNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVDZRNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:13:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:25806 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261674AbVDZRNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:13:06 -0400
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
From: Lee Revell <rlrevell@joe-job.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: David Addison <addy@quadrics.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
In-Reply-To: <Pine.LNX.4.62.0504261829110.2071@dragon.hyggekrogen.localhost>
References: <426E62ED.5090803@quadrics.com>
	 <Pine.LNX.4.62.0504261829110.2071@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:13:04 -0400
Message-Id: <1114535584.5410.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 18:57 +0200, Jesper Juhl wrote:
> > 
> > +static inline void
> > +ioproc_release(struct mm_struct *mm)
> > +{
> 
> Return types on same line as function name makes grep'ing a lot 
> easier/nicer.
> 
> Here's the example from Documentation/CodingStyle : 
> 
>         int function(int x)
>         {

How so?  I never understood the reasons.  This makes it easier to grep
for everything that returns int.  But you make the common case (what
file is function() defined in?) harder.

Lee


