Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUCKSPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUCKSPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:15:16 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:59464 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261628AbUCKSPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:15:11 -0500
Subject: Re: 2.6.4-mm1
From: Redeeman <lkml@metanurb.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040311100957.00dd6e7f.akpm@osdl.org>
References: <20040310233140.3ce99610.akpm@osdl.org>
	 <1079024816.5325.2.camel@redeeman.linux.dk>
	 <200403111453.20866.norberto+linux-kernel@bensa.ath.cx>
	 <20040311100957.00dd6e7f.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079028899.5327.4.camel@redeeman.linux.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 19:14:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i didnt do anything more than patch with mm1, is there a patch for doing
that spin_unlock_irq()? :)

On Thu, 2004-03-11 at 19:09, Andrew Morton wrote:
> Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> wrote:
> >
> > Redeeman wrote:
> >  > hey andrew, i have a problem with this kernel, when it boots, it lists
> >  > vp_ide and stuff, and then suddenly after that my screen gets flodded
> >  > with sys traces and stuff, i cant even read it, so fast they come, and
> >  > the syste doesnet go further
> > 
> >  Same here. bad: scheduling while atomic. .config attached (no dmesg as I have 
> >  no experience with serial consoles yet.)
> 
> Did you remove the spin_unlock_irq() from the end of mpage_writepages()?
-- 
Regards, Redeeman
redeeman@metanurb.dk

