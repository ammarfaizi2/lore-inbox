Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbRGJOZl>; Tue, 10 Jul 2001 10:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266422AbRGJOZV>; Tue, 10 Jul 2001 10:25:21 -0400
Received: from weta.f00f.org ([203.167.249.89]:41346 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266421AbRGJOZQ>;
	Tue, 10 Jul 2001 10:25:16 -0400
Date: Wed, 11 Jul 2001 02:25:09 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@ns.caldera.de>, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: Re: How many pentium-3 processors does SMP support?
Message-ID: <20010711022509.C31966@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010710161943.A7785@caldera.de>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 04:19:43PM +0200, Christoph Hellwig wrote:

    The number of CPUs is currently globally limited to 32 by NR_CPUS in
    include/linux/threads.h.

Really?

<pause>

Ah, so it is... yes, making this architecture dependant might be a
good idea. Large PPC and MIPS boxen need to adjust this already. Also,
someone did a starfire port, I think that had 64 processors, not sure.

    You can.  But you cannot buy 32-processor PII (-Xeon) systems that are
    supported by Linux.

What is the limit here? The 8/16 way SE chipsets?

    > In anyone from Compaq is reading this, you should send me a 32-way
    > Xeon ASAP just to prove they really work :)
    
    It doesn't.

Oh, then they definately need to send me one.

Are these not MP1.4 based? Something different?



  --cw
