Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWFQVjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWFQVjx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 17:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWFQVjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 17:39:53 -0400
Received: from 1wt.eu ([62.212.114.60]:48648 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750955AbWFQVjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 17:39:53 -0400
Date: Sat, 17 Jun 2006 23:38:24 +0200
From: Willy Tarreau <w@1wt.eu>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4.33-rc1] updated patch kit for gcc-4.1.1
Message-ID: <20060617213824.GE13255@w.ods.org>
References: <200606172052.k5HKq5IX002958@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606172052.k5HKq5IX002958@harpo.it.uu.se>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikael,

On Sat, Jun 17, 2006 at 10:52:05PM +0200, Mikael Pettersson wrote:
> An updated patch kit allowing gcc-4.1.1 to compile the 2.4.33-rc1 kernel is now available:
> <http://user.it.uu.se/~mikpe/linux/patches/2.4/patch-gcc4-fixes-v15-2.4.33-rc1>
> 
> Changes since the previously announced version of the patch kit
> <http://marc.theaimsgroup.com/?l=linux-kernel&m=114149697417107&w=2>:
> 
> - Merged the fixes for gcc-4.1 into the baseline patch kit for gcc-4.0.
> - I previously reported that gcc-4.1.0 built ppc32 kernels that oopsed
>   in shrink_dcache_parent(). gcc-4.1.1 fixed this issue.
> - The architectures known to work in kernel 2.4.33-rc1 + this patch kit
>   with gcc-4.1.1 and gcc-4.0.3 are i386, x86-64, and ppc32.

Thanks for still maintaining this patchset. I sometimes have coworkers
complain that they cannot build 2.4 anymore because they have let their
distro automatically upgarde gcc to 4.x. I will be able to point your
site to them. I was also thinking about updating my page on "linux
kernel useful patches" with this last update, but noticed you still have
a "patch-more-gcc4-fixes" file. Is it absolutely needed or just a cleanup ?

> /Mikael

Regards,
Willy

