Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316641AbSERDHB>; Fri, 17 May 2002 23:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316652AbSERDHA>; Fri, 17 May 2002 23:07:00 -0400
Received: from waste.org ([209.173.204.2]:8879 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316641AbSERDG7>;
	Fri, 17 May 2002 23:06:59 -0400
Date: Fri, 17 May 2002 22:06:50 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Dave Jones <davej@suse.de>
cc: Andrea Arcangeli <andrea@suse.de>, Keith Owens <kaos@ocs.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <20020518033358.A15417@suse.de>
Message-ID: <Pine.LNX.4.44.0205172159090.28917-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2002, Dave Jones wrote:

> needs splitting up some more, but it's a lot of work, and I don't
> think kbuild2.5 alone is going to make that much difference
> in this regard.

No, but it does give much more incentive. With a broken makefile, you
still have to do "make clean dep all" after you've untangled the
headers, so not much is gained, with a working makefile, touching headers
doesn't mean clean build to get it right.

Keith, I would take silence from Linus to mean one of two things:
a) he's already decided he doesn't want it and he's being a dork
b) he's waiting to hear from someone who's taste he trusts before
   accepting it.

So you might try selling some of his lieutenants on your implementation
(even if doesn't make sense for them to adopt it into their trees until
Linus does).

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

