Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288954AbSAZCEJ>; Fri, 25 Jan 2002 21:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288957AbSAZCD7>; Fri, 25 Jan 2002 21:03:59 -0500
Received: from ns.suse.de ([213.95.15.193]:23059 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288954AbSAZCDp>;
	Fri, 25 Jan 2002 21:03:45 -0500
Date: Sat, 26 Jan 2002 03:03:41 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
Message-ID: <20020126030341.A9651@wotan.suse.de>
In-Reply-To: <p73y9il7vlr.fsf@oldwotan.suse.de> <Pine.LNX.4.33.0201251741430.16917-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201251741430.16917-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 05:53:57PM -0800, Linus Torvalds wrote:
> 
> On 26 Jan 2002, Andi Kleen wrote:
> >
> > It doesn't explain the Athlon speedups. On athlon cli is ~4 cycles.
> 
> .. and it probably serializes the instruction stream.

I have word from AMD engineering that it doesn't stall the pipeline
or serializes.

(I asked the question during the design of the x86-64 syscall code) 

-Andi
