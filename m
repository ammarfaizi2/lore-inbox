Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVAELYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVAELYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVAELYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:24:31 -0500
Received: from [213.146.154.40] ([213.146.154.40]:46992 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262330AbVAELY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:24:26 -0500
Date: Wed, 5 Jan 2005 11:24:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050105112425.GD30954@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Jack O'Quin <joq@io.com>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104865034.8346.4.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 01:57:13PM -0500, Lee Revell wrote:
> On Tue, 2005-01-04 at 18:20 +0000, Christoph Hellwig wrote:
> > On Tue, Jan 04, 2005 at 01:16:54PM -0500, Lee Revell wrote:
> > > Got a patch?  Code talks, BS walks.  This is working perfectly, right
> > > now, and is being used by thousands of Linux ausio users.
> > 
> > Which still doesn't mean it's the right design.  And no, I don't need the
> > feature so I won't write it.  If you want a certain feature it's up to
> > you to implement it in a way that's considered mergeable.
> > 
> 
> Please specify what's wrong with it.  So far all your objection amounts
> to is "I don't like it".

It's tying privilegues to uids/gids, and it does so in an overcomplicated
way and just for an extremly tiny, specialized subset of available
privilegues.

In short it's a very specialized hack.

> If you do have anything other that your opinion to back up your
> assertion that it's a bad design, you should have raised it months ago
> when this was first posted.  Now that we have it to a mergeable state
> (as far as the people who worked on it are concerned), you want to pop
> up and say "Nope, bad design"?

I'm very sorry but I don't have the time to comment on every single patch
posted somewhere.  All the review and core kernel work I do on lkml is in my
unpaid spare time.  If you want me to review specific things in a deadline
or want me to implement features in a way that fits the kernel grand plan
(which doesn't equal to it actually beeing accepted by other kernel
developers), you're free to contract me.

