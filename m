Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272427AbSISTL6>; Thu, 19 Sep 2002 15:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272429AbSISTL6>; Thu, 19 Sep 2002 15:11:58 -0400
Received: from dsl-213-023-020-102.arcor-ip.net ([213.23.20.102]:11925 "EHLO
	starship") by vger.kernel.org with ESMTP id <S272427AbSISTLw>;
	Thu, 19 Sep 2002 15:11:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave Olien <dmo@osdl.org>
Subject: Re: [2.5] DAC960
Date: Thu, 19 Sep 2002 21:16:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
References: <E17odbY-000BHv-00@f1.mail.ru> <E17r2Rr-0001Vk-00@starship> <20020919114934.A27630@acpi.pdx.osdl.net>
In-Reply-To: <20020919114934.A27630@acpi.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17s6nH-0000xq-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 September 2002 20:49, Dave Olien wrote:
> I've been doing more work on the driver.  Wednesday, I was
> going crazy because the data I read back from the device
> was SOMETIMES NOT the same data I wrote there.
> 
> On Thursday, I switched from Linux 2.5.34 to Linux 2.5.36.
> Now, the driver reads back the same data it wrote.  There must
> have been some bio changes in 2.5.36.  2.5.36 also
> calls the driver shutdown notifier routine, which 2.5.34 didn't.
> This uncovered a coding bug that causes a kernel OOPS during shutdown.
> That'll be fixed in the next patch.
> 
> I'm about to test changes that put the command and status memory
> mailboxes into dma memory regions.  Once I've tested that,
> I'll send you a new patch (Probably on Monday after week end
> testing).
> 
> After that, I'll change the status reporting structures to be in dma
> memory regions.  Expect a patch containing that maybe the end of
> next week, or the Monday following ( September 30).

I was in the process of writing to you as this one came in...

I have booted 2.5.34 and 2.5.36, the same controller as yours, on my dual
PIII box and it is apparently functioning well.  I have not done any kind
of load testing yet.

Congratulations!  I presume you are now the DAC960 maintainer, subject to
approval from on high of course, and assuming you are willing.  I'd like
to do some spelling changes, just obvious ones for now, like removing
spelling wrappers from standard kernel interfaces.  Want patches?

-- 
Daniel
