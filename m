Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262412AbSI3Q5y>; Mon, 30 Sep 2002 12:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262443AbSI3Q5y>; Mon, 30 Sep 2002 12:57:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17645 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262412AbSI3Q5x>;
	Mon, 30 Sep 2002 12:57:53 -0400
Date: Mon, 30 Sep 2002 19:12:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@sgi.com>
Cc: lord@sgi.com, Arjan van de Ven <arjanv@redhat.com>, <cw@f00f.org>,
       <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
In-Reply-To: <20020930194529.A15138@sgi.com>
Message-ID: <Pine.LNX.4.44.0209301911180.21901-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Sep 2002, Christoph Hellwig wrote:

> On Mon, Sep 30, 2002 at 06:38:03PM +0200, Ingo Molnar wrote:
> > see the workqueues patch i posted a couple of minutes ago. Does this solve
> > XFS's problems?
> 
> Not exactly.  All your work on one queue is internally serialize.  An
> totally unserialized workqueue would be best for XFS.

you can create as many queues as you wish - one per CPU for example. Or
one per mounted fs per CPU.

	Ingo

