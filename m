Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262851AbSJAVQZ>; Tue, 1 Oct 2002 17:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262852AbSJAVQZ>; Tue, 1 Oct 2002 17:16:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57323 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262851AbSJAVQY>;
	Tue, 1 Oct 2002 17:16:24 -0400
Date: Tue, 1 Oct 2002 23:31:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@sgi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <20021002002235.A3910@sgi.com>
Message-ID: <Pine.LNX.4.44.0210012331050.25070-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Oct 2002, Christoph Hellwig wrote:

> On Tue, Oct 01, 2002 at 06:24:50PM +0200, Ingo Molnar wrote:
> > 
> > the attached (compressed) patch is the next iteration of the workqueue
> > abstraction. There are two major categories of changes:
> 
> What about forcing a flush in destory_workqueue?

yes, most definitely - this was done in yesterday's patch but forgot it in 
today's.

	Ingo

