Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbUBOXFA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUBOXFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:05:00 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:38766 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265231AbUBOXE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:04:56 -0500
Date: Sun, 15 Feb 2004 17:04:53 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: Micah Anderson <micah@riseup.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: stable/vanilla+(O)1
In-Reply-To: <20040215230209.GP14140@riseup.net>
Message-ID: <Pine.LNX.4.58.0402151703160.8636@ryanr.aptchi.homelinux.org>
References: <1pCCK-5S4-23@gated-at.bofh.it> <402FF424.4050902@uchicago.edu>
 <20040215230209.GP14140@riseup.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I see.  The broken-up patches are still composite.  Sorry.

-- 
Ryan Reich
ryanr@uchicago.edu

On Sun, 15 Feb 2004, Micah Anderson wrote:

> I am aware that -ck patches have this, however it has a lot of other
> things that I am not interested in entertaining. I want to isolate
> variables, and getting preemptible, low latency and CK interactivity
> in addition to O(1) makes it hard for me to gauge what is going on.
> I prefer to change one thing at a time.
>
> Micah
>
>
> On Sun, 15 Feb 2004, Ryan Reich wrote:
>
> > Micah Anderson wrote:
> > >Is there a patch to the stable/vanilla 2.4 kernel tree which provides
> > >the O(1) scheduler code from 2.6? The closest thing I can find is:
> > >
> > >http://people.redhat.com/mingo/O(1)-scheduler/sched-HT-2.4.22-ac1-A0
> > >
> > >which is for AC (and is also A0), is there a newer 2.4.23/24 patch
> > >that works against stock? The above patch fails miserably against a
> > >stock 2.4.22 kernel.
> > >
> > >There is ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/
> > >the latest which is sched-O1-rml-2.4.20-rc3-1.patch, but that too
> > >fails horribly on a stock 2.4.22.
> > >
> > >I've been crawling through list archives, but have yet to find
> > >anything, so I am reduced to asking. :)
> >
> > The -ck patchset has this and numerous other fun things in it. It can be
> > found at http://www.plumlocosoft.com/kernel/ .
> >
> > --
> > Ryan Reich
> > ryanr@uchicago.edu
>
