Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbRCTTAd>; Tue, 20 Mar 2001 14:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbRCTTAX>; Tue, 20 Mar 2001 14:00:23 -0500
Received: from unthought.net ([212.97.129.24]:58568 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S131018AbRCTTAT>;
	Tue, 20 Mar 2001 14:00:19 -0500
Date: Tue, 20 Mar 2001 19:59:37 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Serge Orlov <sorlov@con.mcst.ru>, linux-kernel@vger.kernel.org,
        sorlov@mcst.ru
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Message-ID: <20010320195937.A1759@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Serge Orlov <sorlov@con.mcst.ru>, linux-kernel@vger.kernel.org,
	sorlov@mcst.ru
In-Reply-To: <3AB7A169.53F4E4BB@con.mcst.ru> <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Mar 20, 2001 at 10:43:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2001 at 10:43:33AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 20 Mar 2001, Serge Orlov wrote:
> >
> > I upgraded one of our computer happily running 2.2.13 kernel
> > to 2.4.2. Everything was OK, but compilation time of our C++
> > project greatly increased (1.4 times slower). I investigated the
> > issue and found that g++ spends 7 times more time in kernel.
> > The reason for this is big vm map:
> 
> Cool. Somebody actually found a real case.
> 
> I'll fix the mmap case asap. Its' not hard, I just waited to see if it
> ever actually triggers. Something like g++ certainly counts as major.

Uber-cool !  :)

> 
> Are you willing to test out patches?

Definitely.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
