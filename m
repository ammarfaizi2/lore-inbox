Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132386AbRAVRnl>; Mon, 22 Jan 2001 12:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132426AbRAVRnb>; Mon, 22 Jan 2001 12:43:31 -0500
Received: from [63.95.87.168] ([63.95.87.168]:23304 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S132386AbRAVRnY>;
	Mon, 22 Jan 2001 12:43:24 -0500
Date: Mon, 22 Jan 2001 12:43:19 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Jonathan Earle <jearle@nortelnetworks.com>
Cc: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
Message-ID: <20010122124319.A30815@xi.linuxpower.cx>
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCC5@zcard00g.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCC5@zcard00g.ca.nortel.com>; from jearle@nortelnetworks.com on Mon, Jan 22, 2001 at 11:04:50AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2001 at 11:04:50AM -0500, Jonathan Earle wrote:
> WRONG!!!
> 
> Not documenting your code is not a sign of good coding, but rather shows
> arrogance, laziness and contempt for "those who would dare tamper with your
> code after you've written it".  Document and comment your code thoroughly.
> Do it as you go along.  I was also taught to comment nearly every line - as
> part of the coding style used by a large, international company I worked for
> several years ago.  It brings the logic of the programmer into focus and
> makes code maintenance a whole lot easier.  It also helps one to remember
> the logic of your own code when you revisit it a year or more hence.

Not wrong: You should document the interface, and any strange gotchas that
you faced while writing the function (like hardware bugs, etc). Then, if the
next person can't understand the code by reading it:

1. He's not qualified to change it.
*OR*
2. The code is crap, it needs to be rewritten anyways, good interface
documentation makes that possible.

Documenting every detail just encourages people with a paper thin
understanding to go and foul it up in subtile ways, it's better that they be
completely clueless and screw it up obviously.

Good code is simple, clean, and obvious. Sometimes, some code can't be clean
because it's facing a very hard problem, all the more reason to leave it to
gurus. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
