Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310285AbSCGLvj>; Thu, 7 Mar 2002 06:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310289AbSCGLvi>; Thu, 7 Mar 2002 06:51:38 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:39858 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S310291AbSCGLvS>;
	Thu, 7 Mar 2002 06:51:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.19pre2aa1
Date: Thu, 7 Mar 2002 12:46:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        riel@surriel.com, hch@infradead.org
In-Reply-To: <20020307092119.A25470@dualathlon.random> <E16iw3h-00037V-00@starship.berlin> <20020307114721.GD786@holomorphy.com>
In-Reply-To: <20020307114721.GD786@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16iwM4-00037h-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 12:47 pm, William Lee Irwin III wrote:
> On March 7, 2002 11:49 am, William Lee Irwin III wrote:
> >> 4096 threads blocked on I/O is already approaching or exceeding the
> >> scalability limits of other core kernel subsystems.
> 
> On Thu, Mar 07, 2002 at 12:27:41PM +0100, Daniel Phillips wrote:
> > I think he meant that with larger ram it's easy to justify making the wait
> > table a little looser, to gain a tiny little bit of extra performance.
> > That seems perfectly reasonable to me.  Oh, and there's also the observation
> > that machines with larger ram tend to be more heavily loaded with processes,
> > just because one can.
> 
> And these processes will not be waiting on pages as often, either, as
> pages will be more plentiful.
> 
> From the reports I've seen, typical numbers of waiters on pages, even
> on large systems, are as much as an order of magnitude fewer in number
> than 4096. It would seem applications need to wait on pages less with
> the increased memory size.

Uh Yup.

-- 
Daniel
