Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSETRcu>; Mon, 20 May 2002 13:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316162AbSETRct>; Mon, 20 May 2002 13:32:49 -0400
Received: from holomorphy.com ([66.224.33.161]:55431 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316161AbSETRcs>;
	Mon, 20 May 2002 13:32:48 -0400
Date: Mon, 20 May 2002 10:32:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Bug with shared memory.
Message-ID: <20020520173236.GB2046@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <20020520043040.GA21806@dualathlon.random> <1232380940.1021886032@[10.10.2.3]> <20020520163724.GI21806@dualathlon.random> <221520000.1021915385@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Andrea Arcangeli wrote:
>> How much are you swapping in your workload? (as said the fast paths are
>> hurted a little so it's expected that it's almost as fast as mainline
>> with a kernel compile, similar to the fact we also add anon pages to the
>> lru list). I think you're only exercising the fast paths in your
>> workload, not the memory balancing that is the whole point of the change.

On Mon, May 20, 2002 at 10:23:05AM -0700, Martin J. Bligh wrote:
> No swapping. We fixed the horrendous locking problem we were seeing,
> but this was only one test - obviously others are needed. But I think we're
> in agreement that it's time to give it a beating and see what happens ;-)

There's no mystery or secrecy to the locking work, really just overzealous
(which is good wrt. locking changes) QA and a conservative release schedule.


Cheers,
Bill
