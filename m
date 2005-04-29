Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVD2N3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVD2N3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVD2N1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:27:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:56283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262598AbVD2N0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:26:51 -0400
Date: Fri, 29 Apr 2005 06:26:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: colin@colino.net, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       debian-powerpc@lists.debian.org, torvalds@osdl.org
Subject: Re: 2.6.12-rc3 cpufreq compile error on ppc32
Message-Id: <20050429062604.536cb193.akpm@osdl.org>
In-Reply-To: <20050429131519.GA6158@infradead.org>
References: <20050421092611.37df940b@colin.toulouse>
	<1114129070.5996.36.camel@gaston>
	<20050425222039.5421fa64@jack.colino.net>
	<20050429131519.GA6158@infradead.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Apr 25, 2005 at 10:20:39PM +0200, Colin Leroy wrote:
>  > > > One of Ben's patches ("ppc32: Fix cpufreq problems") went in 2.6.12-
>  > > > rc3, but it depended on another patch that's still in -mm only: 
>  > > > add-suspend-method-to-cpufreq-core.patch
>  > > > 
>  > > > In addition to this, there's a third patch in -mm that fixes
>  > > > warnings and line length to the previous patch, but it doesn't
>  > > > apply cleanly anymore. It's named add-suspend-method-to-cpufreq-
>  > > > core-warning-fix.patch
>  > > 
>  > > Yup, please, Andrew, get those 2 to Linus.
>  > 
>  > Just a heads-up : I didn't see these go into the git tree?
> 
>  still not in.  Linus, can you please put in the patch below from benh?
> 
> 
>  Index: linux-work/drivers/cpufreq/cpufreq.c

This patch is missing a warning fix.  I'll send the correct one.
