Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262998AbVAFTin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVAFTin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbVAFTgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:36:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:1448 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262996AbVAFTfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:35:41 -0500
Date: Thu, 6 Jan 2005 20:32:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Bill Davidsen <davidsen@tmr.com>,
       Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050106193214.GK3096@stusta.de>
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com> <20050103183621.GA2885@thunk.org> <4d8e3fd30501060603247e955a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd30501060603247e955a@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:03:26PM +0100, Paolo Ciarrocchi wrote:
> 
> What's wrong in keeping the release management as is now plus
> introducing a 2.6.X.Y series of kernels ?
> 
> In short:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109882220123966&w=2

Currently (2.6.10), there would have been 11 such branches.

If a security vulnerability was found today, this meant backporting and 
applying the patch to 11 different kernel versions, the oldest one being 
more than one year old.

With more 2.6 versions, there would be even more branches, and the 
oldest ones becoming more and more different from the current codebase.

You could at some point start dropping the oldest branches, but this 
would mean a migration to a more recent branch for all users of this 
branch.

OTOH, if you migrated relatively late at 2.4.17 to the 2.4 branch, this 
branch is still actively maintained today, more than 3 years later.

> Best,
> Paolo Ciarrocchi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

