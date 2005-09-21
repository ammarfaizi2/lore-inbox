Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbVIUPL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVIUPL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVIUPL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:11:26 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:58769 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750977AbVIUPLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:11:25 -0400
Date: Wed, 21 Sep 2005 17:11:24 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] eliminate CLONE_* duplications
Message-ID: <20050921151124.GB10137@MAIL.13thfloor.at>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050921092132.GA4710@MAIL.13thfloor.at> <Pine.LNX.4.61.0509211252160.3743@scrub.home> <20050921143954.GA10137@MAIL.13thfloor.at> <Pine.LNX.4.61.0509211648240.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509211648240.3743@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 04:53:51PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 21 Sep 2005, Herbert Poetzl wrote:
> 
> > please elaborate _why_ we would want a bunch of
> > additional DEFINE entries in each arch instead of a
> > simple include file?
> 
> It's more important to keep related definition together and organize
> them logically, than spreading definitions over zillion header files
> for the only purpose to be usable from asm. If you want to cleanup
> sched.h and properly break it up, please go ahead, but I'm afraid that
> will be a lot more work than adding a few defines to asm-offsets.c.

well, I thought that is what my patch did, so please
could you elaborate on the 'properly' part, as this
might be the missing information here ...

TIA,
Herbert

> bye, Roman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
