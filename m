Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVAGBvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVAGBvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVAGBvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:51:09 -0500
Received: from mail.dif.dk ([193.138.115.101]:12737 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261299AbVAGBiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:38:21 -0500
Date: Fri, 7 Jan 2005 02:49:46 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/4] let's kill verify_area
In-Reply-To: <20050106172624.7cc2a142.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501070246160.3430@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0501070212560.3430@dragon.hygekrogen.localhost>
 <20050106172624.7cc2a142.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > verify_area() if just a wrapper for access_ok() (or similar function or 
> > dummy function) for all arch's.
> 
> This sounds more like "let's kill Andrew".  I count 489 instances in the
> tree.  Please don't expect this activity to take top priority ;)
> 
Heh, right, there's an aspect I hadn't really considered.
I'm not expecting top priority, not at all. This is nowhere near being 
anything important, just something that should happen eventually - so I 
thought, why not just deprecate it now and let it be cleaned up over time 
(and I'll do my share, don't worry :)

Accept the patch if you think it makes sense, drop it if you think it does 
not (or should wait). 


-- 
Jesper Juhl


