Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWBBLHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWBBLHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWBBLHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:07:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15283 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750749AbWBBLHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:07:52 -0500
Date: Thu, 2 Feb 2006 12:07:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
Message-ID: <20060202110738.GA2151@elf.ucw.cz>
References: <1138714918.6869.139.camel@localhost.localdomain> <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com> <1138724479.6869.201.camel@localhost.localdomain> <20060131203552.GG4215@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131203552.GG4215@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > These solutions are going to end up with a lot of unused led triggers on
> > any given system. 
> 
> Perhaps a generic solution isn't feasible, because this isn't really a
> generic problem. The LED stuff has very limited use - you mention
> embedded platforms, perhaps they should just be doing this on their
> own?

LEDs need userland API to be useful in some cases (mail LED). At that
point saying "everybody make your own API" is very bad idea.

(And we have old, ARM-private API at least, already. Idea is to do it
once and do it right).
								Pavel
-- 
Thanks, Sharp!
