Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311587AbSDSGtm>; Fri, 19 Apr 2002 02:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311618AbSDSGtl>; Fri, 19 Apr 2002 02:49:41 -0400
Received: from holomorphy.com ([66.224.33.161]:49056 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S311587AbSDSGtk>;
	Fri, 19 Apr 2002 02:49:40 -0400
Date: Thu, 18 Apr 2002 23:48:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] migration thread fix
Message-ID: <20020419064851.GC21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020419064052.GB21206@holomorphy.com> <Pine.LNX.4.44.0204190639140.3975-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>>> looks perfectly good to me. Even with wli's patch i saw some migration
>>> thread initialization weirdnesses.

On Thu, 18 Apr 2002, William Lee Irwin III wrote:
>> It's a bit of a moot point, but I'd be interested in knowing what sort
>> of weirdnesses those might be for my own edification.

On Fri, Apr 19, 2002 at 06:41:04AM +0200, Ingo Molnar wrote:
> a HT box wouldnt boot without an artificial mdelay(1000) in
> migration_init() - while i havent fully debugged it (given Erich's patch),
> it appeared to be some sort of race between idle thread startup and
> migration init.

I've got a few of those around, I'll see if I can reproduce it. How many
cpu's did you need to bring it out?


Cheers,
Bill
