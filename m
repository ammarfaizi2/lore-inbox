Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbRG0PHi>; Fri, 27 Jul 2001 11:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbRG0PH2>; Fri, 27 Jul 2001 11:07:28 -0400
Received: from weta.f00f.org ([203.167.249.89]:60805 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267602AbRG0PHN>;
	Fri, 27 Jul 2001 11:07:13 -0400
Date: Sat, 28 Jul 2001 03:07:45 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Joshua Schmidlkofer <menion@srci.iwpsd.org>
Cc: Hans Reiser <reiser@namesys.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010728030745.B804@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0107270818120A.06707@widmers.oce.srci.oce.int>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 08:18:12AM -0600, Joshua Schmidlkofer wrote:

        Once, I lost power in on my SQL box, [it was blessedly during
    a period of no use.]  I had to rebuild all the indexes.  Not only
    THAT, but what happens to that box if I lose power whilst in the
    middle of operations?  I am working on the migration plan to move
    that to XFS because of these concerns. [However, I am doing a
    better job of testing with XFS first.]

Sounds like a MySQL bug (assuming data is on disk when perhaps it's
not).  Using either Oracle or Sybase you seem to be able to yank the
power at pretty much any time even under load and things will recovery
gracefully upon restart.





  --cw
