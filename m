Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264824AbTE1SgM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 14:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbTE1SgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 14:36:12 -0400
Received: from mail.eskimo.com ([204.122.16.4]:1550 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id S264824AbTE1SgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 14:36:11 -0400
Date: Wed, 28 May 2003 11:47:37 -0700
To: Jens Axboe <axboe@suse.de>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
       matthias.mueller@rz.uni-karlsruhe.de, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528184737.GA2726@eskimo.com>
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de> <20030528125312.GV845@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528125312.GV845@suse.de>
User-Agent: Mutt/1.5.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 02:53:12PM +0200, Jens Axboe wrote:
> On Wed, May 28 2003, Marc-Christian Petersen wrote:
> > On Wednesday 28 May 2003 13:27, Andrew Morton wrote:
> > 
> > Hi Akpm,
> > 
> > > > Does the attached one make sense?
> > > Nope.
> > nm.
> > 
> > > Guys, you're the ones who can reproduce this.  Please spend more time
> > > working out which chunk (or combination thereof) actually fixes the
> > > problem.  If indeed any of them do.
> > As I said, I will test it this evening. ATM I don't have time to
> > recompile and reboot. This evening I will test extensively, even on
> > SMP, SCSI, IDE and so on.
> 
> May I ask how you are reproducing the bad results? I'm trying in vain
> here...

It might be useful to check what video hardware and X servers people are
using here.  If the behavior is just mouse freezups, the "silken mouse"
feature of XFree might have some effect, since it involves XFree binding
a signal to mouse device events.

-J
