Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273136AbRIPB7X>; Sat, 15 Sep 2001 21:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273143AbRIPB7N>; Sat, 15 Sep 2001 21:59:13 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:35593 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273136AbRIPB7E>; Sat, 15 Sep 2001 21:59:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jens Axboe <axboe@suse.de>, kelley eicher <keicher@nws.gov>
Subject: Re: 0-order allocation failed in 2.4.10-pre8
Date: Sun, 16 Sep 2001 04:06:36 +0200
X-Mailer: KMail [version 1.3.1]
Cc: J <jack@i2net.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BA24EB0.5000402@i2net.com> <Pine.LNX.4.33.0109141342340.14906-100000@home.nohrsc.nws.gov> <20010914210903.E806@suse.de>
In-Reply-To: <20010914210903.E806@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010916015917Z16125-2757+260@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Use the
> 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.9/block-highmem-all
> 
> patch and you can use highmem without having to worry about failed
> 0-order bounce pages allocations.

Right, by using 64 bit DMA instead of bounce buffers.  But aren't there cases
where the 64 bit capable hardware isn't there but somebody still wants to use
highmem?

--
Daniel
