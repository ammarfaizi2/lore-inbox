Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264573AbRFTTSU>; Wed, 20 Jun 2001 15:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264575AbRFTTSK>; Wed, 20 Jun 2001 15:18:10 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:17679 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S264573AbRFTTRx>;
	Wed, 20 Jun 2001 15:17:53 -0400
Date: Wed, 20 Jun 2001 13:14:28 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>, Larry McVoy <lm@bitmover.com>,
        Dan Kegel <dank@kegel.com>, ognen@gene.pbi.nrc.ca,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        laughing@shared-source.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010620131428.B31012@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010619095239.T3089@work.bitmover.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 09:52:39AM -0700, Larry McVoy wrote:
> I think the general thrust of us ``anti-thread'' people is that a few
> are fine, a lot is stupid, and the model encourages a lot.  It's just

There is a huge academic research literature on how to prove that a large
set of threads will all meet deadlines in a realtime system.  Years ago I
made a not-so-brilliant optimization to RTLinux scheduler that had an unanticipated
side effect of only scheduling the first two threads created. Nobody noticed
for months, because RT programmers know that more than 2 threads is 
almost always a design error.  Not always though.
(now we have regression tests so I could not make such an experiment again).



