Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290070AbSBKSnj>; Mon, 11 Feb 2002 13:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290075AbSBKSn3>; Mon, 11 Feb 2002 13:43:29 -0500
Received: from otter.mbay.net ([206.40.79.2]:20488 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S290070AbSBKSnX> convert rfc822-to-8bit;
	Mon, 11 Feb 2002 13:43:23 -0500
From: John Alvord <jalvo@mbay.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Rob Landley <landley@trommello.org>,
        Andreas Dilger <adilger@turbolabs.com>,
        Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Date: Mon, 11 Feb 2002 10:42:43 -0800
Message-ID: <sg3g6ucgk7mbeheh81l23pepjmvv4sifh1@4ax.com>
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com> <20020209092607.UHF12059.femail26.sdc1.sfba.home.com@there> <20020211115104.A37@toy.ucw.cz>
In-Reply-To: <20020211115104.A37@toy.ucw.cz>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002 11:51:04 +0000, Pavel Machek <pavel@suse.cz>
wrote:

>Hi!
>
>> > I don't see why everyone who is using BK is expecting Linus to do a pull.
>> > In the non-BK case, wasn't it always a "push" model, and Linus would not
>> > "pull" from URLs and such?
>> 
>> I'm all for it.  I think it's a good thing.
>> 
>> In the absence of significant latency issues, pull scales better than push.  
>> It always has.  Push is better in low bandwidth situations with lots of idle 
>> capacity, but it breaks down when the system approaches saturation.
>> 
>> Pull data is naturally supplied when you're ready for it (assuming no 
>> significant latency to access it).  Push either scrolls by unread or piles up 
>> in your inbox and gets buried until it goes stale.  Web pages work on a pull 
>> model, "push" was an internet fad a few years ago that failed for a reason.  
>> When push models hit saturation it breaks down and you wind up with the old 
>> "I love lucy" episode with the chocolate factory.  Back in the days where 
>
>What's "i love lucy" episode?
>									Pavel
"I Love Lucy" was a 1950s sitcom on television, one of the first and
very good indeed.

In the episode referred to, Lucy and her friend Ethel get hired as
candy-packers in a candy factory. The candies come by on a conveyer
belt and the girls put them in boxes. Everything went smoothly... the
manager reviewed the situation, and congratulated them. Then they
increased the conveyer belt flow. After a few more cycles, the candy
was coming too fast. So they started taking the candies, stuffing them
into pockets, blouses, mouths... and the scene ends with the manager
arriving back madder then heck.

john
