Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285070AbRLQJgE>; Mon, 17 Dec 2001 04:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285065AbRLQJfy>; Mon, 17 Dec 2001 04:35:54 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:9200 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S285067AbRLQJfn>; Mon, 17 Dec 2001 04:35:43 -0500
Date: Mon, 17 Dec 2001 01:34:45 -0800
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
Message-ID: <20011217013445.A30669@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200112141734.RAA20953.aeb@cwi.nl> <Pine.LNX.4.33.0112141224200.2957-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112141224200.2957-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 14, 2001 at 12:25:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@transmeta.com) wrote:
> 
> On Fri, 14 Dec 2001 Andries.Brouwer@cwi.nl wrote:
> >
> > The new POSIX 1003.1-2001 is explicit about what kill(-1,sig)
> > is supposed to do. Maybe we should follow it.
> 
> Well, we should definitely not do it in 2.4.x, at least not until proven
> that no real applications break.
> 
> But I applied it to 2.5.x, let's see who (if anybody) hollers.

I had to back this change out of 2.5.1 in order to get a sane shutdown.
killall5 -15 is commiting suicide ;-(

cheers,
-chris
