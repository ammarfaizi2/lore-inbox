Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbREFCWT>; Sat, 5 May 2001 22:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbREFCV7>; Sat, 5 May 2001 22:21:59 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:48912 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131244AbREFCUq>; Sat, 5 May 2001 22:20:46 -0400
Date: Sun, 6 May 2001 14:20:43 +1200
From: Chris Wedgwood <cw@f00f.org>
To: linux-kernel@vger.kernel.org,
        BitKeeper Development Source <dev@work.bitmover.com>
Subject: Re: Wow! Is memory ever cheap!
Message-ID: <20010506142043.B31269@metastasis.f00f.org>
In-Reply-To: <20010505095802.X12431@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010505095802.X12431@work.bitmover.com>; from lm@bitmover.com on Sat, May 05, 2001 at 09:58:02AM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I'm burning it in right now, I wrote a little program which fills
    it with different test patterns and then reads them back to make
    sure they don't lose any bits.  Seems to be working, it's done
    about 30 passes.

I wrote something similar to test an Alpha with a flakey L2 cache; it
didn't find anything. However, a script that did kernel compiles in a
loop soon finds errors.

I don't know much about memory testing, other than it is hard, really
hard -- and there is some magic in the way gcc access memory that
seems to trigger nasties.

It has been suggested that a good thesis would be to distill whatever
magic gcc has for testing memory and study that :)
    
    1.5GB for $400.  Amazing.  No more whining from you guys that
    BitKeeper uses too much memory :-)

1.5GB without ECC? Seems like a disater waiting to happen? Is ECC
memory much more expensive?


  --cw
