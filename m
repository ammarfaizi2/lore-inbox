Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274930AbRIXUFn>; Mon, 24 Sep 2001 16:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274928AbRIXUFe>; Mon, 24 Sep 2001 16:05:34 -0400
Received: from femail38.sdc1.sfba.home.com ([24.254.60.32]:59390 "EHLO
	femail38.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274930AbRIXUFQ>; Mon, 24 Sep 2001 16:05:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Date: Mon, 24 Sep 2001 13:05:38 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there> <20010924185303.B10117@emma1.emma.line.org>
In-Reply-To: <20010924185303.B10117@emma1.emma.line.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010924200537.SRVB23487.femail38.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 September 2001 09:53 am, Matthias Andree wrote:
> On Mon, 24 Sep 2001, Nicholas Knight wrote:
> > > Turn it off (I have no idea of internals, but I presume it'll
> > > still be a write-through cache, so reading back will still be
> > > served from the buffer). Do hdparm -W0 /dev/hd[a-h].
> >
> > I'm sorry, but that's not acceptable.
> > Please note the dd timings at the bottom of this message.
>
> Well, of course, turning off the cache will cause performance
> penalties, but it at least gives you a chance to get away with a
> recoverable file system should the power fail or the box crash.

Would you like to read the rest of my message please? Cheap UPS's can 
provide protection against power failures. If your data is that 
valuble, you can afford a cheap UPS to give you 5 minutes to shut down.

>
> > Yes, a typical desktop user isn't going to notice much, even a
> > normal webserver or fileserver not dealing with constant updates
> > may not, but certain workloads will. These workloads are real
> > enough that telling people to disable write caching out of hand is
> > a bad idea.
>
> I switched a box to ext3 with write caches off in expectance of
> multiple power outages during works, and NOTHING happened. I expect
> that box is now writing 4 times slower than before, I have no real
> figures, and it's still "smooth enough" in spite of 2.4.9.

Would you like to read it AGAIN? I specificaly said that MOST people 
would not notice a real difference.

>
> > Keep in mind also, that you may be putting your data and
> > filesystems in more risk by not using a write cache as with using
> > it.
>
> Utterly non-sense.
>
> Linear writing as dd mostly does is BTW something which should never
> be affected by write caches.

Explain the numbers then.
I followed *YOUR* instructions for disabling write caching.
