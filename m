Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUBOXCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbUBOXCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:02:17 -0500
Received: from mail.riseup.net ([216.162.217.191]:42129 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S265215AbUBOXCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:02:15 -0500
Date: Sun, 15 Feb 2004 17:02:09 -0600
From: Micah Anderson <micah@riseup.net>
To: Ryan Reich <ryanr@uchicago.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stable/vanilla+(O)1
Message-ID: <20040215230209.GP14140@riseup.net>
References: <1pCCK-5S4-23@gated-at.bofh.it> <402FF424.4050902@uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402FF424.4050902@uchicago.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am aware that -ck patches have this, however it has a lot of other
things that I am not interested in entertaining. I want to isolate
variables, and getting preemptible, low latency and CK interactivity
in addition to O(1) makes it hard for me to gauge what is going on.
I prefer to change one thing at a time. 

Micah


On Sun, 15 Feb 2004, Ryan Reich wrote:

> Micah Anderson wrote:
> >Is there a patch to the stable/vanilla 2.4 kernel tree which provides
> >the O(1) scheduler code from 2.6? The closest thing I can find is:
> >
> >http://people.redhat.com/mingo/O(1)-scheduler/sched-HT-2.4.22-ac1-A0
> >
> >which is for AC (and is also A0), is there a newer 2.4.23/24 patch
> >that works against stock? The above patch fails miserably against a
> >stock 2.4.22 kernel.
> >
> >There is ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/
> >the latest which is sched-O1-rml-2.4.20-rc3-1.patch, but that too
> >fails horribly on a stock 2.4.22.
> >
> >I've been crawling through list archives, but have yet to find
> >anything, so I am reduced to asking. :)
> 
> The -ck patchset has this and numerous other fun things in it. It can be
> found at http://www.plumlocosoft.com/kernel/ .
> 
> -- 
> Ryan Reich
> ryanr@uchicago.edu
