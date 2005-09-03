Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVICULY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVICULY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 16:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVICULY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 16:11:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751261AbVICULX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 16:11:23 -0400
Date: Sat, 3 Sep 2005 13:06:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-Id: <20050903130632.3124e19b.akpm@osdl.org>
In-Reply-To: <20050903195423.GP3657@stusta.de>
References: <20050901035542.1c621af6.akpm@osdl.org>
	<20050903122126.GM3657@stusta.de>
	<20050903123410.1320f8ab.akpm@osdl.org>
	<20050903195423.GP3657@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Sat, Sep 03, 2005 at 12:34:10PM -0700, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > Hi Andrew,
> > > 
> > > it seems you dropped 
> > > schedule-obsolete-oss-drivers-for-removal-version-2.patch, but there's 
> > > zero mentioning of this dropping in the changelog of 2.6.13-mm1.
> > > 
> > > Can you explain why you did silently drop it?
> > 
> > It spat rejects and when I looked at the putative removal date I just
> > didn't believe it anyway.  Send a rediffed one if you like, but
> > October 2005 is unrealistic.
> 
> That the date is no longer realistic is clear. What disappoints me is 
> that you didn't mention in the changelog of 2.6.13-mm1 where I'd have 
> noticed it.

Sometimes I can't be bothered getting into email threads over relatively
unimportant stuff.  Usually it's related to the number of bugs we have.

> It semms I need my own bookkeeping of patches I sent that are in -mm to 
> notice when they get lost.

This is called "quilt".

> The only positive side effect of this is that 
> I can use this to push you harder to forward some patches of me to Linus 
> that stay unforwarded in -mm for several months...

A single release cycle is 2-3 months.

I'll probably be dropping some of the patches which unexport symbols, btw. 
ANy ones which aren't really, really obvious.  We have a process for this.

