Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTE1Wtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTE1Wto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:49:44 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:63662 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261312AbTE1Wti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:49:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Elladan <elladan@eskimo.com>, Jens Axboe <axboe@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Thu, 29 May 2003 09:03:42 +1000
User-Agent: KMail/1.5.1
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, matthias.mueller@rz.uni-karlsruhe.de,
       manish@storadinc.com, andrea@suse.de, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <20030528125312.GV845@suse.de> <20030528184737.GA2726@eskimo.com>
In-Reply-To: <20030528184737.GA2726@eskimo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305290903.42996.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003 04:47, Elladan wrote:
> On Wed, May 28, 2003 at 02:53:12PM +0200, Jens Axboe wrote:
> > On Wed, May 28 2003, Marc-Christian Petersen wrote:
> > > On Wednesday 28 May 2003 13:27, Andrew Morton wrote:
> > >
> > > Hi Akpm,
> > >
> > > > > Does the attached one make sense?
> > > >
> > > > Nope.
> > >
> > > nm.
> > >
> > > > Guys, you're the ones who can reproduce this.  Please spend more time
> > > > working out which chunk (or combination thereof) actually fixes the
> > > > problem.  If indeed any of them do.
> > >
> > > As I said, I will test it this evening. ATM I don't have time to
> > > recompile and reboot. This evening I will test extensively, even on
> > > SMP, SCSI, IDE and so on.
> >
> > May I ask how you are reproducing the bad results? I'm trying in vain
> > here...
>
> It might be useful to check what video hardware and X servers people are
> using here.  If the behavior is just mouse freezups, the "silken mouse"
> feature of XFree might have some effect, since it involves XFree binding
> a signal to mouse device events.

Xfree 3.3.6, 4.2,4.3
Drivers nvidia, nv, sis, sisfb, vesa, vesafb

are the drivers on the machines where I've seen it happen so far - ie without 
discrimination.

Con
