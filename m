Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318561AbSGZUMk>; Fri, 26 Jul 2002 16:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318564AbSGZUMc>; Fri, 26 Jul 2002 16:12:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3596 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318561AbSGZULo>; Fri, 26 Jul 2002 16:11:44 -0400
Date: Fri, 26 Jul 2002 16:09:06 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Daniel Phillips <phillips@arcor.de>, Andrew Rodland <arodland@noln.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code
In-Reply-To: <Pine.LNX.3.95.1020726100704.2003A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.96.1020726160355.17989A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, Richard B. Johnson wrote:

> The '.' (also called full-stop) is 6 elements long. The ',' is also
> 6 elements long. For a correct implimentation, i.e., one that sounds
> correct, you need to encode a 'pause' element into each symbol. This
> is because the pause between Morse characters is sometimes ahead
> of a character and sometimes behind a character (the pause is ahead
> of characters starting with a dot and after characters ending with a
> dot, including characters of all dots -- except for numbers, which
> have pauses after them). In a previously life, I had to develop
> the correct "fist" to pass the Socond Class Radio Telegraph License.

I had forgotten that, haven't used code in decades, and while I doubt
there will be many of those characters in a panic message (might use !
tho) best to have them.

Unless there are exceptions to the nice rules you present, no need to
encode the pause, just apply your rules to it. Hard to fit dot, dash, and
pause in a single bit in any case.

> This means that it is probably best to use one 8-byte character
> for each Morse-code character.

Clearly, if only to avoid complex code. This looks seriously neat!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

