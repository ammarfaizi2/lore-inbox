Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288280AbSAHUQF>; Tue, 8 Jan 2002 15:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287798AbSAHUP5>; Tue, 8 Jan 2002 15:15:57 -0500
Received: from dsl-213-023-038-231.arcor-ip.net ([213.23.38.231]:36106 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287790AbSAHUPg>;
	Tue, 8 Jan 2002 15:15:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 8 Jan 2002 21:18:30 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <E16Nxjg-00009W-00@starship.berlin> <3C3B4CB7.FEAAF5FC@zip.com.au>
In-Reply-To: <3C3B4CB7.FEAAF5FC@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16O2hc-0000B3-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 08:47 pm, Andrew Morton wrote:
> There's no point in just merging the preempt patch and saying "there,
> that's done".  It doesn't do anything.
> 
> Instead, a decision needs to be made: "Linux will henceforth be a 
> low-latency kernel".

I thought the intention was to make it a config option?

> Now, IF we can come to this decision, then
> internal preemption is the way to do it.  But it affects ALL kernel
> developers.  Because we'll need to introduce a new rule: "it is a
> bug to spend more than five milliseconds holding any locks".
> 
> So.  Do we we want a low-latency kernel?  Are we prepared to mandate
> the five-millisecond rule?   It can be done, but won't be easy, and
> we'll never get complete coverage.  But I don't see the will around
> here.

At least the flaming has gotten a little less ;-)

--
Daniel
