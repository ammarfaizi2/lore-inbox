Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266158AbRG1CDt>; Fri, 27 Jul 2001 22:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266176AbRG1CDj>; Fri, 27 Jul 2001 22:03:39 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:30738 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266158AbRG1CDb>; Fri, 27 Jul 2001 22:03:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roger Larsson <roger.larsson@norran.net>, linux-mm@kvack.org
Subject: Re: [PATCH] MAX_READAHEAD gives doubled throuput
Date: Sat, 28 Jul 2001 04:08:17 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200107280144.DAA25730@mailb.telia.com>
In-Reply-To: <200107280144.DAA25730@mailb.telia.com>
MIME-Version: 1.0
Message-Id: <0107280408170Z.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Saturday 28 July 2001 03:40, Roger Larsson wrote:
> Hi all,
>
> Got wondering why simultaneous streaming is so much slower than
> normal...
>
> Are there any reasons nowadays why we should not attempt to read
> ahead more than 31 pages at once?
>
> 31 pages equals 0.1 MB, it is read from the HD in 4 ms => very close
> to the average access times. Resulting in a maximum of half the
> possible speed.
>
> With this patch copy and diff throughput are increased from 14
> respective 11 MB/s to 27 and 28 !!!

Wheeeeee!  Out of interest, what are the numbers for 2.4.7 vs 
2.4.8-pre1 ?

--
Daniel
