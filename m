Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbUCJVja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUCJVil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:38:41 -0500
Received: from mail.shareable.org ([81.29.64.88]:394 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262859AbUCJVgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:36:52 -0500
Date: Wed, 10 Mar 2004 21:36:50 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] different proposal for mq_notify(SIGEV_THREAD)
Message-ID: <20040310213650.GC7341@mail.shareable.org>
References: <404B2C46.90709@colorfullife.com> <20040310203857.GA7341@mail.shareable.org> <404F814C.1070202@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404F814C.1070202@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> >The difference is that your proposal eliminates those fds.
> >But there is no reason that I can see why mq_notify() should be
> >optimised in this way and futexes not.
> > 
> >
> I would start with message queues, but the mechanism must be generic 
> enough to be used for futexes, etc.
> 
> The main open question is if I should write something new or if I can 
> reuse netlink.

What about extending epoll to handle non-fd event sources?
Is netlink cleaner than that?  (I've never used or looked at netlink).

-- Jamie
