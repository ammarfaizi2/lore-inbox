Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbRECTUc>; Thu, 3 May 2001 15:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbRECTUX>; Thu, 3 May 2001 15:20:23 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:15886 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S132571AbRECTUN>; Thu, 3 May 2001 15:20:13 -0400
Date: Thu, 3 May 2001 13:20:10 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Why recovering from broken configs is too hard
Message-ID: <20010503132010.A2934@mail.harddata.com>
In-Reply-To: <20010503034755.A27693@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010503034755.A27693@thyrsus.com>; from esr@thyrsus.com on Thu, May 03, 2001 at 03:47:55AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 03:47:55AM -0400, Eric S. Raymond wrote:
> OK, so you want CML2's "make oldconfig" to do something more graceful than
> simply say "Foo! You violated this constraint! Go fix it!"

After all this combinatorics I still do not know an answer to a simple
question.  With the current system I can do

   grep -v '^#' .config > config.stripped

copy 'config.stripped' back to .config, type 'make oldconfig' and hold
<Return> for a while to get my old .config back.  This is actually
very useful, and used every day, although maybe not precisely in the
manner as above. :-)

So, the question is: can I do something something like that with CML2?
If the answer is "no" then something is very seriously missing and no
references to halting problems can cover that.  If, OTOH, the answer
is "yes" then what is a big trouble?

   Michal
