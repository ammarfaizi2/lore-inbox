Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVKWUQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVKWUQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVKWUQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:16:27 -0500
Received: from tim.rpsys.net ([194.106.48.114]:12220 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932292AbVKWUQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:16:26 -0500
Subject: Re: [PATCH] split sharpsl_pm.c into generic and corgi/spitz
	specific parts
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051123194927.GA22375@elf.ucw.cz>
References: <20051123130350.GA23090@elf.ucw.cz>
	 <1132754229.8016.55.camel@localhost.localdomain>
	 <20051123194927.GA22375@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 20:16:05 +0000
Message-Id: <1132776965.8016.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 20:49 +0100, Pavel Machek wrote:
> > 1. We probably shouldn't (can't?) make changes like this in -rc
> > kernels 
> 
> No, it does not really belong in -rc. I was hoping you would merge it
> in your tree so I do not have big patch here and could keep only
> collie changes...

Right, I misunderstood that. I'll happily maintain an in progress
version of that split-up patch in the Zaurus tree.

> > I have a proposal for how we proceed with this:
> > 
> > After 2.6.15 is released, I envisage a patch which splits the common
> > sections of sharpsl_pm.c into arm/common and arm/mach-pxa/sharpsl.h into
> > include/arm/hardware/sharpsl_pm.h. I'm happy to generate that patch if
> > necessary and pass it to Russell. I'll try and create a patch to show
> > the structure I'm aiming for in the next couple of days but at the
> > moment we don't know exactly which code is common and I'd prefer to try
> > and do the split in one go. 
> 
> Ok, works for me. So I'll now concentrate on getting collie working
> and leave infrastructure to you...

Sounds good to me.

Richard




