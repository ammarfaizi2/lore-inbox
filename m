Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWCWSed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWCWSed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWCWSec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:34:32 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:13712 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1422649AbWCWSeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:34:31 -0500
Date: Thu, 23 Mar 2006 19:35:28 +0100
From: Mattia Dongili <malattia@linux.it>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
Subject: Re: swap prefetching merge plans
Message-ID: <20060323183528.GB4386@inferi.kami.home>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ck@vds.kolivas.org
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603231804.36334.kernel@kolivas.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc6-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Mar 23, 2006 at 06:04:36PM +1100, Con Kolivas wrote:
> On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
> > A look at the -mm lineup for 2.6.17:
> 
> > mm-implement-swap-prefetching.patch
> > mm-implement-swap-prefetching-fix.patch
> > mm-implement-swap-prefetching-tweaks.patch
> 
> >   Still don't have a compelling argument for this, IMO.
> 
> For those users who feel they do have a compelling argument for it, please 
> speak now or I'll end up maintaining this in -ck only forever.  I've come to 

I have just 256MB on this laptop and I know its limits.
IME swap prefetch helps expecially when I need to open some memory
demanding application for just a few mintues (OO.org, gimp on large
images, pretty large builds, any 3D app) and then go back to my usual
<high number> of xterms.

I did definitely noticed the difference when Andrew dropped the patch
the first time. As already said, it seems so natural the idea of
swapping-in when some room is available that I immediately got used to
having this functionality and I support its inclusion.

Thanks
-- 
mattia
:wq!
