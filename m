Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284745AbRLEWOI>; Wed, 5 Dec 2001 17:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284751AbRLEWNt>; Wed, 5 Dec 2001 17:13:49 -0500
Received: from zero.tech9.net ([209.61.188.187]:37380 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284533AbRLEWNh>;
	Wed, 5 Dec 2001 17:13:37 -0500
Subject: Re: Scheduler Cleanup
From: Robert Love <rml@tech9.net>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011205135851.D1193@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011126114610.B1141@w-mikek2.des.beaverton.ibm.com>
	<Pine.LNX.4.33.0111280145300.3429-100000@localhost.localdomain> 
	<20011205135851.D1193@w-mikek2.des.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 17:13:14 -0500
Message-Id: <1007590396.28567.6.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-05 at 16:58, Mike Kravetz wrote:

> FYI - I have been having a heck of a time getting our MQ scheduler to
> work well in 2.4.16/2.5.0.  The problem was mainly with performance
> when running (I'm afraid to say) VolanoMark.  Turns out that the above
> change makes a big difference in this benchmark when running with the
> MQ scheduler.  There is an almost 50% drop in performance on my 8 way.
> I suspect that one would not see such a dramatic drop (if any) with
> the current scheduler as its performance is mostly limited by lock
> contention in this benchmark.

Ehh, odd.  How does the dropped performance compare to MQ performance
before 2.4.16?  In other words, are we solving problems in the newer
kernels and now MQ is becoming overhead?

> Now, I'm aware that very few people are actively using our MQ scheduler,
> and even fewer care about VolanoMark performance (perhaps no one on this
> list).  However, this seemed like an interesting observation.

Perhaps, but many (myself) are interested in a multi-queue
scheduler...:)

	Robert Love

