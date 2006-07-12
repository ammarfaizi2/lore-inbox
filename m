Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWGLJH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWGLJH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 05:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWGLJH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 05:07:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:672 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750962AbWGLJH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 05:07:27 -0400
Date: Wed, 12 Jul 2006 11:07:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: pavel@ucw.cz, roubert@df.lth.se, stern@rowland.harvard.edu,
       dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
In-Reply-To: <20060711183647.5c5c0204.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607121056170.12900@scrub.home>
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
 <20060710094414.GD1640@igloo.df.lth.se> <Pine.LNX.4.64.0607102356460.17704@scrub.home>
 <20060711124105.GA2474@elf.ucw.cz> <Pine.LNX.4.64.0607120016490.12900@scrub.home>
 <20060711224225.GC1732@elf.ucw.cz> <Pine.LNX.4.64.0607120132440.12900@scrub.home>
 <20060711165003.25265bb7.akpm@osdl.org> <Pine.LNX.4.64.0607120213060.12900@scrub.home>
 <20060711173735.43e9af94.akpm@osdl.org> <Pine.LNX.4.64.0607120248050.12900@scrub.home>
 <20060711183647.5c5c0204.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Jul 2006, Andrew Morton wrote:

> > Traditionally that responsibility is in the hands of whose who break it in 
> > the first place
> 
> If that person cannot reproduce the problem but another skilled kernel
> developer can then it would make sense for he-who-can-reproduce-it to do
> some work.
> 
> Still, I doubt if that's the case here.
> 
> 
> Is the below correct?
> 
> Old behaviour:
> 
> 	a) press alt
> 	b) press sysrq
> 	c) release alt
> 	d) press T
> 	e) release T
> 	f) release sysrq
> 
> New behaviour:
> 
> 	a) press alt
> 	b) press sysrq
> 	c) release sysrq
> 	d) press T
> 	e) release T
> 	f) release alt
> 
> If so, then the old behaviour was weird and the new behaviour is sensible. 

It may be weird, but it was documented and people know about it.

> What, actually, is the problem?

It changes the behaviour, it will annoy the hell out of people like me who 
have to deal with different kernels and expect this to just work. :-(
Since then has it been acceptable to just go ahead and break stuff? This 
problem doesn't really look unsolvable, so why is my request to fix the 
damn thing so unreasonable?

bye, Roman
