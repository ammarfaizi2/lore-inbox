Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUH0KiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUH0KiP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUH0KiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:38:15 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:52242 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261875AbUH0KiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:38:00 -0400
Message-ID: <2ff21628040827033840b1576e@mail.gmail.com>
Date: Fri, 27 Aug 2004 16:08:00 +0530
From: BAIN <bainonline@gmail.com>
Reply-To: BAIN <bainonline@gmail.com>
To: Lei Yang <leiyang@nec-labs.com>
Subject: Re: Compression filter for Loopback device
Cc: pmarques@grupopie.com, Phillip Lougher <phillip@lougher.demon.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <2ff2162804082703342bca4594@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <951A499AA688EF47A898B45F25BD8EE80126D4DB@mailer.nec-labs.com> <2ff2162804082703342bca4594@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi one thing i missed to mention.

i do know about linuxcc project 
http://linuxcc.sf.net

but swap/compressed block device/ram is several degrees less intrusive
on kernel.

BAIN

On Fri, 27 Aug 2004 16:04:33 +0530, BAIN <bainonline@gmail.com> wrote:
> Hi people,
> 
> I missed this mail for almost a month, but neway
> i was also looking at something similar but failed to find nething,
> (donno why zloop didn't show up on sf search)
> 
> My main reason to search something like this was triggered due to the
> discussion on lkml about the necessity of the swap.
> 
> The idea i had was to mount a swap partition over a compressed block
> device implemented in the ram, this way few of my biggest problems in
> current projects would be solved,
> 
> 1. The project is embedded project and is running out of ram quite
> frequently, i have bunch of monitor stuff in userspace which is
> triggered only at moderate intervals and does not need to be in memory
> all the time. swap is what is required here but unfortunately i have
> no backing store for swap. (not all the tasks kick in at one time
> neway so swap will be just fine).
> 
> 2. This also does seem to be good idea on top of IMHO otherwise silly
> stuff like this
> http://kerneltrap.org/node/view/3660 [ using ram as swap : kerneltrap.org ]
> 
> 3. And according to discussion on lkml few months back , kernel is
> suppose to work better if swap is enabled ?
> 
> NE progress neone of you have made so far
> 
> i was kinda alone doing this so this is going very slow, but will
> speed up the things if i am backed up :).
> 
> BAIN
> 
> 
> On Mon, 26 Jul 2004 08:48:21 -0400, Lei Yang <leiyang@nec-labs.com> wrote:
> > Hmm, I am a bit surprised to see this...
> > Since I am the one who posted the question, could anyone pls give me
> > some clue of what is going on? Or something like a summary. Many many
> > thanks!!
> >
> > Lei
