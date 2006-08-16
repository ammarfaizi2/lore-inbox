Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWHPRnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWHPRnk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWHPRnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:43:40 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:35498 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S1751228AbWHPRnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:43:39 -0400
Date: Wed, 16 Aug 2006 19:43:30 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Jiri Benc <jbenc@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Message-ID: <20060816174329.GC17650@ojjektum.uhulinux.hu>
References: <20050427124911.6212670f@griffin.suse.cz> <20060815092551.GA17881@ojjektum.uhulinux.hu> <20060816191139.5d13fda8@griffin.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816191139.5d13fda8@griffin.suse.cz>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:11:39PM +0200, Jiri Benc wrote:
> On Tue, 15 Aug 2006 11:25:52 +0200, Pozsar Balazs wrote:
> > Recently I had similar problems as you described below, that's how I 
> > found your email. (My exact problem is that there's no link when I plug 
> > in a cable, reloading the driver a few times usually helps.)
> > The problem is, that since you made the patch, the uli526x driver has 
> > been split out from the tulip driver.
> > Do you know anything about the current state of the uli526x driver 
> > regarding the problems you tried patch?
> 
> I use the card with new (split out) uli526x driver with no problem. Your
> problems are probably unrelated.

So, just to make it clear: if you boot without cable plugged in, let 
the driver load, and then plug the cable in, do you have link?
For me, it does not have link until I rmmod the module.


Do you have any idea what the problem could be, or could I send you any 
info that would help debug it?

Thanks,

-- 
pozsy
