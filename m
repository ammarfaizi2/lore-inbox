Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265353AbUEZI1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUEZI1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 04:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUEZI1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 04:27:14 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:49133 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265353AbUEZI1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 04:27:12 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 01:30:09 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040526075506.GV1833@holomorphy.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRC9sgdMQPzdX6xQa+pZADA46ulsgAAJYUw
Message-Id: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No. I am not making any assertions whatsoever. I am just calling out that
systems that run happily from physical memory and are not in need of swap
should never sacrifice an ounce of performance for even drastic improvements
to swap performance. Swap is a band-aid for saving money on memory and a few
years ago, it allowed you to save a substantial amount of money. 

Whether the cost savings for utilizing swap vs buying more memory are
substantial as of late is subject to opinion, but I cannot think of a system
that I have sized in the last three years where swap was expected to be used
except in un-anticipated memory shortfalls. In fact, if I didn't plan to
store crash dumps on the swap device, I think I would have omitted swap all
together in many configurations.

I have worked at large fortune 500 companies with deep pockets though, so
this may not be the case for many. I make this point though because I think
if it isn't the case yet, it will be in the near future as memory becomes
even cheaper because the trend certainly exists.

As for your short, two sentence comment below, let me save you the energy of
insinuations and translate your message the way I read it: 

-------------------------------------------------------------------------
I don't recognize your name, therefore you can't possibly have a valuable
opinion on the direction VM system development should go. I doubt you have
an actual performance problem to share, but if you do, please share it and
go away so that we can work on solving the problem.
--------------------------------------------------------------------------

My response:

Get over yourself.

Regards,

--Buddy

-----Original Message-----
From: William Lee Irwin III [mailto:wli@holomorphy.com] 
Sent: Wednesday, May 26, 2004 12:55 AM
To: Buddy Lumpkin
Cc: orders@nodivisions.com; linux-kernel@vger.kernel.org
Subject: Re: why swap at all?

On Wed, May 26, 2004 at 12:31:16AM -0700, Buddy Lumpkin wrote:
> This is a really good point. I think the bar should be set at max
> performance for systems that never need to use the swap device. 
> If someone wants to tune swap performance to their hearts content, so be
it.
> But given cheap prices for memory, and the horrible best case performance
> for swap, an increase in swap performance should never, ever come at the
> expense of performance for a system that has been sized such that
executable
> address spaces, libraries and anonymous memory will fit easily within
> physical ram.
> This of course doesn't address the VM paging storms that happen due to
large
> amounts of file system writes. Once the pagecache fills up, dirty pages
must
> be evicted from the pagecache so that new pages can be added to the
> pagecache.

If you've got a real performance issue, please describe it properly
instead of asserting without evidence the existence of one.


-- wli

