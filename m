Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422744AbWHXWJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422744AbWHXWJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbWHXWJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:09:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422744AbWHXWJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:09:11 -0400
Date: Thu, 24 Aug 2006 15:09:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 4] md: Introduction
Message-Id: <20060824150900.36bd9285.akpm@osdl.org>
In-Reply-To: <20060824173647.19026.patches@notabene>
References: <20060824173647.19026.patches@notabene>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006 17:40:56 +1000
NeilBrown <neilb@suse.de> wrote:

> 
> Following are 4 patches against 2.6.18-rc4-mm2
> 
> The first 2 are bug fixes which should go in 2.6.18, and apply
> equally well to that tree as to -mm.
> 
> The latter two should stay in -mm until after 2.6.18.
> 
> The second patch is maybe bigger than it absolutely needs to be as a bugfix.
> If you like I can stripe out all the rcu-extra-carefulness as a separate
> patch and just leave the important bit which involves moving the
> atomic_add down twenty-something lines.
> 
> Thanks,
> NeilBrown
> 
>  [PATCH 001 of 4] md: Fix recent breakage of md/raid1 array checking
>  [PATCH 002 of 4] md: Fix issues with referencing rdev in md/raid1.
>  [PATCH 003 of 4] md: new sysfs interface for setting bits in the write-intent-bitmap
>  [PATCH 004 of 4] md: Remove unnecessary variable x in stripe_to_pdidx().

The second patch is against -mm and doesn't come within a mile of applying
to mainline.

