Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274852AbRIZHGJ>; Wed, 26 Sep 2001 03:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274853AbRIZHGA>; Wed, 26 Sep 2001 03:06:00 -0400
Received: from mail.zmailer.org ([194.252.70.162]:48909 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S274852AbRIZHFn>;
	Wed, 26 Sep 2001 03:05:43 -0400
Date: Wed, 26 Sep 2001 10:05:56 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Kirill Ratkin <kratkin@yahoo.com>
Cc: Gangadhar Uppala <gangadhar.uppala@wipro.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How to exchange data between Kernel & User Space
Message-ID: <20010926100556.F11046@mea-ext.zmailer.org>
In-Reply-To: <20010926074142.E11046@mea-ext.zmailer.org> <20010926061124.61082.qmail@web11907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010926061124.61082.qmail@web11907.mail.yahoo.com>; from kratkin@yahoo.com on Tue, Sep 25, 2001 at 11:11:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 11:11:24PM -0700, Kirill Ratkin wrote:
> Use mmap and see exmaple here:
> http://www.kernelnewbies.org/code/mmap/

	That is partial possibility, but the example is
	incomplete, and dangerous in case the machine
	has more than about 800 MB memory. (E.g. it has,
	and uses, HIGHMEM facility.)

	It is also completely wrong approach in case
	the interface does not need to be high bandwidth
	payload delivering directly into user space,
	but e.g. control some aspects of hardware.
	("network interface" sounds, to me, very much
	 of NETDEV class device at which MMAP tricks
	 in general are wrong.)

	The person asking for pointers didn't give
	enough details for good advice.  Supplying
	the many ropes which Linux has for hanging
	oneself is not a good advice.

> Regards,

  /Matti Aarnio
