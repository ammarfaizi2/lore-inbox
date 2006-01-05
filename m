Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWAEVOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWAEVOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWAEVOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:14:55 -0500
Received: from soundwarez.org ([217.160.171.123]:35558 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932210AbWAEVOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:14:54 -0500
Date: Thu, 5 Jan 2006 22:14:38 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 80 column line limit?
Message-ID: <20060105211438.GA1408@vrfy.org>
References: <20060105130249.GB29894@vrfy.org> <84144f020601050532l56c15be1i4938a84f6c212960@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020601050532l56c15be1i4938a84f6c212960@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 03:32:28PM +0200, Pekka Enberg wrote:
> On 1/5/06, Kay Sievers <kay.sievers@vrfy.org> wrote:
> > Can't we relax the 80 column line rule to something more comfortable?
> > These days descriptive variable/function names are much more valuable,
> > I think.
> 
> I don't see the point, really. If your nesting is within reasonable
> limits, long names are usually not a problem.

Well, it always feels silly, to line wrap manually like in this patch:
  http://lkml.org/lkml/mbox/2005/12/2/219
And sometimes it would just be nice to have "len" called "buflen"
or whatever, but that makes things even worse with the 80's rule. :)

I just wanted to do some whitespace cleanup and add named prototypes
to include/linux/device.h but a lot of lines are already exceeding
80 columns and wrapping the lines would make the file even more
unreadable, that's why I was asking. :)

> And your nesting is too deep, it should be fixed.

It's not about nesting, if that's the reason, the number of tabs
should get a maximum specified instead.

> Out of curiosity, what limit do you think
> would work better to you?

Normal 80, but if it makes sense 120, then usually the editor will line
wrap, which is in most cases better to read than starting lines at
column 60.

Thanks,
Kay
