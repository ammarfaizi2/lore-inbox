Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268561AbRGYM4g>; Wed, 25 Jul 2001 08:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268564AbRGYM42>; Wed, 25 Jul 2001 08:56:28 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19984 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268561AbRGYMz4>; Wed, 25 Jul 2001 08:55:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rob Landley <landley@webofficenow.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 14:57:37 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, Ben LaHaise <bcrl@redhat.com>,
        Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.LNX.4.21.0107241750090.2263-100000@freak.distro.conectiva> <01072501092707.00520@starship> <01072415352102.00631@localhost.localdomain>
In-Reply-To: <01072415352102.00631@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <01072514573703.00907@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 21:35, Rob Landley wrote:
> I don't suppose we could get some variant of your initial post into
> /Documentation/vm/HowItActuallyWorks.txt?  (I take it the biggest
> "detail" you glossed over was the seperation of memory into zones?)

I glossed over a lot of big details:

  - zones
  - type of pages: anonymous, swap cache, file, high, buffer, ramdisk
  - interaction with page cache
  - various flavors of swap-in and swap-out paths
  - shared memory and the swap cache
  - locking strategy
  - aging strategy
  - scanning policy
  - deadlock and livelock avoidance measures
  - unloaded vs loaded behaviour
  - effect of load changes
  - out of memory handling
  - clustering (or lack of it)
  - IO throttling

Each of these is a topic all by itself.  You'll find all of them 
discussed extensively here on lkml.

--
Daniel
  
