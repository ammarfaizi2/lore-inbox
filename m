Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWEULi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWEULi6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 07:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWEULi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 07:38:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:19947 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751527AbWEULi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 07:38:57 -0400
Date: Sun, 21 May 2006 13:38:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
Subject: Re: [patch] i386, vdso=[0|1] boot option and /proc/sys/vm/vdso_enabled
Message-ID: <20060521113858.GA25770@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org> <20060520010303.GA17858@elte.hu> <20060519181125.5c8e109e.akpm@osdl.org> <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org> <20060520085351.GA28716@elte.hu> <20060520022650.46b048f8.akpm@osdl.org> <20060521110300.GB21117@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521110300.GB21117@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > vmm:/home/akpm# echo 1 > /proc/sys/vm/vdso_enabled 
> > vmm:/home/akpm# 
> > vmm:/home/akpm> ls -l
> > zsh: segmentation fault  ls -l
> 
> Andrew, could you try the patch below, does your FC1 box work with it 
> applied and CONFIG_COMPAT_VDSO enabled? (no need to pass any boot 
> options)

in case this doesnt do the trick, could you also try booting with the 
norandmaps boot option?

	Ingo
