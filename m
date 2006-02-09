Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422746AbWBIKMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbWBIKMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422749AbWBIKMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:12:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422746AbWBIKME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:12:04 -0500
Date: Thu, 9 Feb 2006 02:11:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: MIke Galbraith <efault@gmx.de>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [k2.6.16-rc1-mm5] kernel BUG at include/linux/mm.h:302!
Message-Id: <20060209021136.410f1128.akpm@osdl.org>
In-Reply-To: <1139478652.7867.9.camel@homer>
References: <1139473463.8028.13.camel@homer>
	<43EAFF6D.1040604@yahoo.com.au>
	<20060209004712.3998e336.akpm@osdl.org>
	<1139478652.7867.9.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIke Galbraith <efault@gmx.de> wrote:
>
> On Thu, 2006-02-09 at 00:47 -0800, Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > >
> > > MIke Galbraith wrote:
> > > > Greetings,
> > > > 
> > > > Excuse me if this is already known, I've been too busy tinkering to read
> > > > lkml.
> > > > 
> > > 
> > > It should be fixed as of current -git (not sure about the latest
> > > -mm though). It would be good if you could verify that 2.6.16-rc2-git7
> > > works OK for you.
> > > 
> > 
> > This was a -mm kernel - how do we know it's not -mm breakage?
> 
> It _appears_ to be mm breakage.  I just built/ran rc1 with the same
> config, and it works fine.
> 
> RL is calling, so I can't dig right this minute... in a couple hours I
> hope to be able to start though.
> 
> Before I get to the 'what comes next' compile marathon, any likely
> candidates?

rc2-mm1?

>  (or Nick, do you have the supposed fix handy?)

Yeah, I'm still scratching my head over the mystery fix.

