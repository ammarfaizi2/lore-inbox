Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbRGVQht>; Sun, 22 Jul 2001 12:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbRGVQhj>; Sun, 22 Jul 2001 12:37:39 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:26400
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S266578AbRGVQh1>; Sun, 22 Jul 2001 12:37:27 -0400
Date: Sun, 22 Jul 2001 09:37:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Brian J. Watson" <Brian.J.Watson@compaq.com>,
        Larry McVoy <lm@bitmover.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Common hash table implementation
Message-ID: <20010722093732.A6000@work.bitmover.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"Brian J. Watson" <Brian.J.Watson@compaq.com>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <01071815464209.12129@starship> <3B58CBA3.BD2C194@compaq.com> <01072122255100.02679@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <01072122255100.02679@starship>; from phillips@bonn-fries.net on Sat, Jul 21, 2001 at 10:25:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21, 2001 at 10:25:51PM +0200, Daniel Phillips wrote:
>   1) How random is the hash
>   2) How efficient is it

The hash is not the only part to consider for performance.  The rest of the
code is important as well.  The code I pointed you to has been really carefully
tuned for performance.  And it can be made to be MP safe, SGI did that and
managed to get 455,000 random fetches/second on an 8 way R4400 (each of
these is about the same as the original Pentium at 150Mhz).
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
