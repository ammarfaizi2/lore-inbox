Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVKXMnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVKXMnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 07:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVKXMnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 07:43:40 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:28261 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750739AbVKXMnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 07:43:40 -0500
Date: Thu, 24 Nov 2005 13:41:39 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: + dont-include-schedh-from-moduleh.patch added to -mm tree
In-Reply-To: <20051123104302.6669df5e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0511241304330.1477@gockel.physik3.uni-rostock.de>
References: <200511050726.jA57QPs7009905@shell0.pdx.osdl.net>
 <Pine.LNX.4.63.0511231328020.27662@gockel.physik3.uni-rostock.de>
 <20051123104302.6669df5e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Andrew Morton wrote:
> Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> >
> > Andrew, what are your plans for these patches?
> 
> Slam it in after 2.6.15, put fingers in ears?

I'll certainly listen when the patches go in.
I'll rerun my analysis to catch most of the problems. But I will allways 
be late by two or three days because the analysis takes it's time.

The (well-known) problem is that at the time when patches are allowed to 
go in, the rate of change is so high that I need to fix some dozen files 
per day.
In a more quiet period (e.g., two or the days after most of the changes 
are in), I'd probably be able to catch most (if not all) of the problems 
by myself with

We'll see how it goes.
I'd really like to get the procedure right as my next patch to really cut 
down sched.h (ab)use will affect about 10x as many files.

> >  Shall I send an updated dont-include-schedh-from-moduleh.patch whose 
> >  changelog reflects the current state of testing?
> 
> You can send a new changelog if you like, but I'd prefer not to do a
> wholesale replacement of a tested patch.
> 

OK. I'll not update the changelog now as it will be out of date anyways 
when 2.6.15 arrives.

Thanks,
Tim
