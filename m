Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286437AbRLTWuA>; Thu, 20 Dec 2001 17:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286443AbRLTWty>; Thu, 20 Dec 2001 17:49:54 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:34065 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S286437AbRLTWtn>; Thu, 20 Dec 2001 17:49:43 -0500
Date: Thu, 20 Dec 2001 23:49:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011220234939.A32287@suse.cz>
In-Reply-To: <20011220143247.A19377@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011220143247.A19377@thyrsus.com>; from esr@thyrsus.com on Thu, Dec 20, 2001 at 02:32:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:32:47PM -0500, Eric S. Raymond wrote:

> I guess it's a pretty quiet week in kernel-hacker land.  Must be,
> otherwise people would have better things to do than argue over KB
> vs. KiB.  The alternative would be to conclude that significant
> portions of the lkml population prefer flaming to coding, and that
> couldn't possibly be the case, could it?

The kb versus KB versus KiB versus whatever may come next was always a
very flammable cause.

Now my opinion on this would be: By sticking KiB everywhere nothing is
helped. To the knowledgeable, it's nothing new that memory is measured
in binary units, while ethernet speed in decimal ones. To the newbie,
KiB is about as cryptical as KB and he'll never know which is which,
because as a newbie (s)he didn't read the standards.

And of course, every search-and-replace cleanup will always upset many
people regardless which direction it goes.

On the other hand, making documentation less ambiguous is always a good
thing. I'd suggest a more careful approach, adding descriptive wording
in places where bits and bytes may be confused, and where binary or
decimal prefixes may be.

And speaking of the 1 Mbps connection - I fear that in many cases
that'll be 1024000 bytes per second. What M is that? Binary or decimal?
Who does care?

-- 
Vojtech Pavlik
SuSE Labs
