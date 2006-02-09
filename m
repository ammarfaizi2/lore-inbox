Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbWBIJqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbWBIJqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWBIJqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:46:06 -0500
Received: from mail.gmx.net ([213.165.64.21]:8909 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965228AbWBIJqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:46:05 -0500
X-Authenticated: #14349625
Subject: Re: [k2.6.16-rc1-mm5] kernel BUG at include/linux/mm.h:302!
From: MIke Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20060209004712.3998e336.akpm@osdl.org>
References: <1139473463.8028.13.camel@homer> <43EAFF6D.1040604@yahoo.com.au>
	 <20060209004712.3998e336.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 10:50:52 +0100
Message-Id: <1139478652.7867.9.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 00:47 -0800, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > MIke Galbraith wrote:
> > > Greetings,
> > > 
> > > Excuse me if this is already known, I've been too busy tinkering to read
> > > lkml.
> > > 
> > 
> > It should be fixed as of current -git (not sure about the latest
> > -mm though). It would be good if you could verify that 2.6.16-rc2-git7
> > works OK for you.
> > 
> 
> This was a -mm kernel - how do we know it's not -mm breakage?

It _appears_ to be mm breakage.  I just built/ran rc1 with the same
config, and it works fine.

RL is calling, so I can't dig right this minute... in a couple hours I
hope to be able to start though.

Before I get to the 'what comes next' compile marathon, any likely
candidates?  (or Nick, do you have the supposed fix handy?)

	-Mike

