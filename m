Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130520AbRCTRde>; Tue, 20 Mar 2001 12:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130531AbRCTRd0>; Tue, 20 Mar 2001 12:33:26 -0500
Received: from unthought.net ([212.97.129.24]:9928 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S130520AbRCTRdU>;
	Tue, 20 Mar 2001 12:33:20 -0500
Date: Tue, 20 Mar 2001 18:32:38 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Josh Grebe <squash@primary.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about memory usage in 2.4 vs 2.2
Message-ID: <20010320183238.B1508@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Josh Grebe <squash@primary.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200103190207.UAA13397@senechalle.net> <Pine.LNX.4.21.0103201038140.2405-100000@scarface.primary.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103201038140.2405-100000@scarface.primary.net>; from squash@primary.net on Tue, Mar 20, 2001 at 11:01:52AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2001 at 11:01:52AM -0600, Josh Grebe wrote:
> Greetings,
...
> Doing the math, the 2.4 machine is using 44% of available memory, while
> the 2.2 is using only about 14%.

How is the performance difference ?

...
> These machines are dual P2-400's, with 512M ECC ram, adaptec 2940, and
> dual intel etherexpress pro 100 cards.
> 
> I also tried 2.4.2-ac20 with similar results.
> 
> Am I missing something here? I'd really like to move the farm back up to
> 2.4 series.

Free memory is wasted memory.   It seemed like 2.4 wasted a lot less memory
than 2.2 on your workload.

Could you do some performance measurements (eg. average latency on IMAP
connection or something like that)   ?    It would be great to know wheter
2.4 is better or worse than 2.2  (it's most likely better, since it probably
uses the memory better, but it would be nice to know)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
