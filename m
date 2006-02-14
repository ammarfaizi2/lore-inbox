Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422794AbWBNU1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbWBNU1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422796AbWBNU1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:27:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422794AbWBNU1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:27:36 -0500
Date: Tue, 14 Feb 2006 12:23:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: ak@suse.de, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3-mm1: i386 compilation broken
Message-Id: <20060214122320.21b4459b.akpm@osdl.org>
In-Reply-To: <6bffcb0e0602140554j56d5a95bi@mail.gmail.com>
References: <20060214014157.59af972f.akpm@osdl.org>
	<20060214131715.GA10701@stusta.de>
	<200602141427.49763.ak@suse.de>
	<6bffcb0e0602140554j56d5a95bi@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> Hi,
> 
> On 14/02/06, Andi Kleen <ak@suse.de> wrote:
> > On Tuesday 14 February 2006 14:17, Adrian Bunk wrote:
> > > On Tue, Feb 14, 2006 at 01:41:57AM -0800, Andrew Morton wrote:
> > > >...
> > > > Changes since 2.6.16-rc2-mm1:
> > > >...
> > > > +x86_64-fix-string.patch
> > > >...
> > > >  x86_64 tree updates.
> > > >...
> > >
> > > This patch breaks the compilation on i386:
> >
> > Ok then the -ffreestanding was apparently still needed on other architectures too.
> > I guess that part of the patch can be just dropped.
> >
> > Andrew can you drop that please?
> >
> > -Andi
> 
> Thanks, problem solved!

Andi like to break x86 - I think it's a market-share thing.

I wonder why I didn't hit that problem.

> Andrew can you add this to hot-fixes?

Done.  I backed out the whole patch.
