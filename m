Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbRGTBPN>; Thu, 19 Jul 2001 21:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266428AbRGTBPC>; Thu, 19 Jul 2001 21:15:02 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:5588 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S266425AbRGTBO4>; Thu, 19 Jul 2001 21:14:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
Date: Tue, 17 Jul 2001 15:40:15 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <200107160022.f6G0MBn310960@saturn.cs.uml.edu>
In-Reply-To: <200107160022.f6G0MBn310960@saturn.cs.uml.edu>
MIME-Version: 1.0
Message-Id: <01071715401507.13440@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sunday 15 July 2001 20:22, Albert D. Cahalan wrote:

> An extra 4 bits buys us 6 years maybe. Nice, except that we
> already have people complaining. Maybe somebody remembers when
> the complaining started.

I blame Charles Babbage, myself...

As for the scalable block numbers, assuming moore's law holds at 18 
months/doubling without hitting subatomic quantum weirdness limits, the jump 
from 32 to 64 bits gives us another 48 years.  48 years ago was 1953.  Univac 
(powered by vacuum tubes) hit the market in 1951.  Project whirlwind would do 
prototype work applying transistors to computers in 1954.

Just a sense of perspective.  Scalable block numbers sound cool if they save 
metadata space, but not as a source of extra scalability.  And they sound 
like a can of worms in terms of complexity.

Feel free to bring up the Y2K problem as a counter-example as to why 
"rewriting it when it becomes a problem" is a bad idea.  But the problem 
there was closed (and lost) source code, wasn't it?

Rob

