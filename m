Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275963AbRJPK0c>; Tue, 16 Oct 2001 06:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275968AbRJPK0W>; Tue, 16 Oct 2001 06:26:22 -0400
Received: from ns.ithnet.com ([217.64.64.10]:62983 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S275963AbRJPK0P>;
	Tue, 16 Oct 2001 06:26:15 -0400
Date: Tue, 16 Oct 2001 12:26:27 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Patrick McFarland <unknown@panax.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM
Message-Id: <20011016122627.110964ec.skraw@ithnet.com>
In-Reply-To: <20011015230836.B1314@localhost>
In-Reply-To: <20011015211216.A1314@localhost>
	<9qg46l$378$1@penguin.transmeta.com>
	<20011015230836.B1314@localhost>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 23:08:38 -0400 Patrick McFarland <unknown@panax.com> wrote:

> reading what lang wrote, ive been thinking
> 
> Im on the type of machine that swapping the least is most favorable. rik's vm
seems that it would be able to swap less, and not swap the wrong things enough
of the time.

Well, I cannot really comment on who does what based on the code. But I can see
the results on my machine(s). And what I see is that the current linus-tree
does not swap at all in my environment. Maybe one could say that 1 GB of RAM is
a bit oversized for most of my business, but anyway the point I started
complaining real loud about the former VM (now residing at -ac tree) was when
it came to the point where even my system started to become unusable. I am
therefore _very_ thankful to L. that he drew the line (who else could _and_
would have done it?), and Andrea of course for his work. I do not think that
Riks work is a piece of bs, really not, but it seems to have an inherent
complexity that is _very_ hard to handle. It may well be the proof for the
"keep it simple"-strategy to deliver the best results.
Anyway we should not see it as a political issue, but a friendly competition.
Because in the end, we all want the same: a system we can trust and rely on.
There is nothing wrong with having different opinions as long as you can give
_some_ proof for it. So if you say current -linus tree does more swapping,
please give us some numbers to have a look at.

Regards,
Stephan

