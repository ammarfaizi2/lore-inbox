Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279462AbRKSPYF>; Mon, 19 Nov 2001 10:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279548AbRKSPXz>; Mon, 19 Nov 2001 10:23:55 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:26542 "EHLO
	hawk.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S279547AbRKSPXj>; Mon, 19 Nov 2001 10:23:39 -0500
Date: Mon, 19 Nov 2001 10:26:09 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: I/O tests using elvtune to improve interactive performance
Message-ID: <20011119102609.A3713@earthlink.net>
In-Reply-To: <138.49c8e42.29247804@aol.com> <20011117030611.A214@earthlink.net> <20011119080922.S11826@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011119080922.S11826@suse.de>; from axboe@suse.de on Mon, Nov 19, 2001 at 08:09:22AM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 08:09:22AM +0100, Jens Axboe wrote:
> > Test:	Run growfiles tests from Linux Test Project that really hurt
> > 	interactive performance.  Simultaneously run "ls -laR /".
> > 	Change the elevator read latency value with elvtune.
> > 	Also run mp3blaster tests.
> 
> Interesting tests, thanks. I wonder if you could be convinced to do
> bonnie++ and dbench tests with the same read_latency values used? Also,
> I'm assuming you kept write latency at its default of 16384?
> -- 
> Jens Axboe
> 

Thanks for the feedback.  Write latency was 16384 for all tests.

I'm downloading dbench and bonnie++ now.   I'll check them out.

I'm still not sure how to measure/quantify interactive performance.  

My ideal test will have these components:

1) Simulate and measure user interactive response time.
2) Disk I/O patterns capable of making interactive performance slow.
3) Measurement of I/O throughput.
4) Note how changes with elvtune effect throughput and response time.
5) It's not too boring.  (i.e. type something, use a stop watch).

It's the "measure interactive response time" that I haven't got a handle 
on yet.  I'm looking at the SSBA benchmarks for something that simulates 
users.  I don't know if it measures response time.

I could resort to a stopwatch to test interactive response, but
hopefully, something better will come to mind.
-- 
Randy Hron

