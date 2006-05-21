Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWEUMdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWEUMdc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 08:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWEUMdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 08:33:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751543AbWEUMdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 08:33:31 -0400
Date: Sun, 21 May 2006 05:33:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
Subject: Re: [patch] i386, vdso=[0|1] boot option and
 /proc/sys/vm/vdso_enabled
Message-Id: <20060521053308.2dddc6f5.akpm@osdl.org>
In-Reply-To: <20060521113858.GA25770@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain>
	<20060516064723.GA14121@elte.hu>
	<1147852189.1749.28.camel@localhost.localdomain>
	<20060519174303.5fd17d12.akpm@osdl.org>
	<20060520010303.GA17858@elte.hu>
	<20060519181125.5c8e109e.akpm@osdl.org>
	<Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>
	<20060520085351.GA28716@elte.hu>
	<20060520022650.46b048f8.akpm@osdl.org>
	<20060521110300.GB21117@elte.hu>
	<20060521113858.GA25770@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > vmm:/home/akpm# echo 1 > /proc/sys/vm/vdso_enabled 
> > > vmm:/home/akpm# 
> > > vmm:/home/akpm> ls -l
> > > zsh: segmentation fault  ls -l
> > 
> > Andrew, could you try the patch below, does your FC1 box work with it 
> > applied and CONFIG_COMPAT_VDSO enabled? (no need to pass any boot 
> > options)
> 
> in case this doesnt do the trick,

It doesn't do the trick.

> could you also try booting with the 
> norandmaps boot option?

Nor does that.
