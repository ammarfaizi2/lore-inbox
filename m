Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWJRNjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWJRNjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWJRNjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:39:32 -0400
Received: from unthought.net ([212.97.129.88]:19975 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S932148AbWJRNjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:39:32 -0400
Date: Wed, 18 Oct 2006 15:39:33 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018133933.GA23492@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jens Axboe <jens.axboe@oracle.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	"Phetteplace, Thad (GE Healthcare, consultant)" <Thad.Phetteplace@ge.com>,
	linux-kernel@vger.kernel.org
References: <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk> <20061018122323.GW23492@unthought.net> <1161175344.9363.30.camel@localhost.localdomain> <20061018124420.GI24452@kernel.dk> <4536245B.8070906@yahoo.com.au> <20061018130456.GJ24452@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018130456.GJ24452@kernel.dk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 03:04:57PM +0200, Jens Axboe wrote:
...
> > So you could say you want your database to consume no more than 50%
> > of disk and have your mp3 player get a minimum of 10%. Of course,
> > that doesn't say anything about what the time slices are, or what
> > latencies you can expect (1s out of every 10, or 100ms out of every
> > 1000?).
> 
> As I wrote previously, both a percentage and bandwidth  along with
> desired latency make sense.

The fundamental problem I see, is, that while you can easily measure and
limit the bandwidth, you cannot really make bandwidth guarantees.

All the rest sounds great in my ears :)

-- 

 / jakob

