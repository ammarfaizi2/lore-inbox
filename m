Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWBNVIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWBNVIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422700AbWBNVIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:08:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2570 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422672AbWBNVIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:08:49 -0500
Date: Tue, 14 Feb 2006 22:08:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3-mm1: i386 compilation broken
Message-ID: <20060214210848.GA4330@stusta.de>
References: <20060214014157.59af972f.akpm@osdl.org> <20060214131715.GA10701@stusta.de> <200602141427.49763.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602141427.49763.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 02:27:49PM +0100, Andi Kleen wrote:
> On Tuesday 14 February 2006 14:17, Adrian Bunk wrote:
> > On Tue, Feb 14, 2006 at 01:41:57AM -0800, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.16-rc2-mm1:
> > >...
> > > +x86_64-fix-string.patch
> > >...
> > >  x86_64 tree updates.
> > >...
> > 
> > This patch breaks the compilation on i386:
> 
> Ok then the -ffreestanding was apparently still needed on other architectures too.
> I guess that part of the patch can be just dropped.
>...

This means you'd no longer use the builtins on x86_64 ???

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

