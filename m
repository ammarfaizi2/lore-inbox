Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279003AbRKIBf0>; Thu, 8 Nov 2001 20:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279035AbRKIBfR>; Thu, 8 Nov 2001 20:35:17 -0500
Received: from freeside.toyota.com ([63.87.74.7]:52491 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S279013AbRKIBfL>;
	Thu, 8 Nov 2001 20:35:11 -0500
Message-ID: <3BEB32C7.A80AE2A@lexus.com>
Date: Thu, 08 Nov 2001 17:35:03 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: J Sloan <jjs@pobox.com>, Robert Love <rml@tech9.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Success with 2.4.14 on Compaq 6500
In-Reply-To: <3BE8B460.A23E1A67@pobox.com> <1005109646.884.0.camel@phantasy> <3BE9A506.82D64AE4@lexus.com> <3BEA0078.F938623B@pobox.com> <20011108113615.F27652@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I am happy to report that the server
is standing up under a punishing dbench
load without flinching - and my shell sessions
remain snappy throuough the testins now. In
addition to the stability and responsiveness,
the dbench results are significantly better even
than they were under 2.4.13 -

Now to try again with -preempt....

Thanks for the fix, hope this goes
mainstream asap -

cu

jjs


Jens Axboe wrote:

> On Wed, Nov 07 2001, J Sloan wrote:
> > I think there may be a problem with the
> > compaq smart/2p raid drivers, since
> > the "do_ida_intr" code keeps showing
> > up in the oops, and I have not seen a
> > problem with 2.4.14 on any other system.
>
> Does this fix it?
>
> --
> Jens Axboe
>
>   ------------------------------------------------------------------------
>
>    cpq-dequeue-1Name: cpq-dequeue-1
>                 Type: Plain Text (text/plain)

