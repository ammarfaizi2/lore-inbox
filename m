Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289326AbSA1TJd>; Mon, 28 Jan 2002 14:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289331AbSA1TJY>; Mon, 28 Jan 2002 14:09:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289326AbSA1TJM>;
	Mon, 28 Jan 2002 14:09:12 -0500
Message-ID: <3C55A028.3FD71164@zip.com.au>
Date: Mon, 28 Jan 2002 11:02:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Don't use dbench for benchmarks
In-Reply-To: <20020128144319.67654.qmail@web9203.mail.yahoo.com>,
		<20020128144319.67654.qmail@web9203.mail.yahoo.com> <E16VGmX-0000BQ-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On January 28, 2002 03:43 pm, Alex Davis wrote:
> > > Continuing that theme: please don't use dbench for benchmarks.  At all.
> > > It's an unreliable indicator of anything in particular except perhaps
> > > stability.  Please, use something else for your benchmarks.
> >
> > What do you suggest as an acceptable benchmark???
> 
> A benchmark that tests disk/file system create/read/write/delete throughput,
> as dbench is supposed to?  Though I haven't used it personally, others
> (Arjan) have suggested tiobench:
> 
>   http://tiobench.sourceforge.net/
> 

Also http://www.iozone.org/

Really, iozone isn't a benchmark as much as the "engine" of
a benchmark.  It has so many options that you can use it
to build higher-level, more intelligent test suites by invoking it
in specific ways.  read/write, mmap, MS_SYNC, MS_ASYNC, O_DIRECT,
aio, O_SYNC, fsync(), multiple threads, ...



-
