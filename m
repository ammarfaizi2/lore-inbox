Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288402AbSAHVtQ>; Tue, 8 Jan 2002 16:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288435AbSAHVtG>; Tue, 8 Jan 2002 16:49:06 -0500
Received: from dsl-213-023-038-231.arcor-ip.net ([213.23.38.231]:22283 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288402AbSAHVsr>;
	Tue, 8 Jan 2002 16:48:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 8 Jan 2002 22:51:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
In-Reply-To: <Pine.LNX.4.33L.0201081907040.2985-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201081907040.2985-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16O49z-0000BD-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 10:08 pm, Rik van Riel wrote:
> On Tue, 8 Jan 2002, Daniel Phillips wrote:
> 
> > The preemptible kernel can reschedule, on average, sooner than the
> > scheduling-point kernel, which has to wait for a scheduling point to
> > roll around.
> 
> The preemptible kernel ALSO has to wait for a scheduling point
> to roll around, since it cannot preempt with spinlocks held.

Think about the relative amount of time spent inside spinlocks vs regular 
kernel.

> Considering this, I don't see much of an advantage to adding
> kernel preemption.

And now?

--
Daniel
