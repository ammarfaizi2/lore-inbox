Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273155AbRIJCUk>; Sun, 9 Sep 2001 22:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273153AbRIJCU3>; Sun, 9 Sep 2001 22:20:29 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:57029
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S273152AbRIJCUQ>; Sun, 9 Sep 2001 22:20:16 -0400
Date: Sun, 09 Sep 2001 22:20:34 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1324600000.1000088434@tiny>
In-Reply-To: <20010910021513Z16066-26183+696@humbolt.nl.linux.org>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org>
 <20010910035519.B11329@athlon.random>
 <20010910020752Z16066-26184+197@humbolt.nl.linux.org>
 <20010910021513Z16066-26183+696@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, September 10, 2001 04:22:25 AM +0200 Daniel Phillips
<phillips@bonn-fries.net> wrote:

> On September 10, 2001 04:15 am, Daniel Phillips wrote:
>> On September 10, 2001 03:55 am, Andrea Arcangeli wrote:
>> > getblk should unconditionally alloc a new bh entity and only care to
>> > map it to the right cache backing store with a pagecache hash lookup.
>> 
>> To feel anything like the original the new getblk has to be idempotent: 
>> subsequent calls return the same block.
> 
> Err, buffer_head

How about subsequent calls for the same offset with the same blocksize need
to return the same buffer head?

-chris


