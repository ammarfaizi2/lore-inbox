Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbSLLS1K>; Thu, 12 Dec 2002 13:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267476AbSLLS1K>; Thu, 12 Dec 2002 13:27:10 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:58635 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267471AbSLLS1J>; Thu, 12 Dec 2002 13:27:09 -0500
Subject: Re: "bio too big" error
From: Wil Reichert <wilreichert@yahoo.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021212120836.GA5717@reti>
References: <1039572597.459.82.camel@darwin>  <20021212120836.GA5717@reti>
Content-Type: text/plain
Organization: 
Message-Id: <1039718098.433.13.camel@darwin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Dec 2002 13:34:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, ditching patch 5 makes my lvm functional again.  Things are
definately better now.  I haven't attempted to stress it, but the entire
hanging console / zombie process bit has gone away.  Everything appears
to work normally.  A couple test cp's shows nothing abnormal, but
playing an ogg still results in the following.

Dec 12 13:32:20 darwin kernel: bio too big device ide2(33,0) (256 > 255)
Dec 12 13:32:51 darwin last message repeated 3 times
Dec 12 13:33:55 darwin last message repeated 6 times

Any other tests I should do?

Wil

On Thu, 2002-12-12 at 07:08, Joe Thornber wrote:
> On Tue, Dec 10, 2002 at 09:17:45PM -0500, Wil Reichert wrote:
> > Hi,
> > 
> > I'm getting a "bio too big" error with 2.5.50.  I've got a 330G lvm2
> > partition formatted with ext3 using the -T largefile4 parameter. 
> > Everything seems ok at first, but any sort of access will die very
> > unhappily with said error messsage after about 10 seconds of operation
> > or so.  The only google search results are the patch submission.  Eeek.
> 
> Could you try the patchset below please ?  (you may need to knock out
> patch 5 until we get to the bottom of that particular bug).
> 
> http://people.sistina.com/~thornber/patches/2.5-stable/2.5.51/2.5.51-dm-2.tar.bz2
> 
> - Joe
-- 
Wil Reichert <wilreichert@yahoo.com>

