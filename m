Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136499AbREDUNL>; Fri, 4 May 2001 16:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136492AbREDUNA>; Fri, 4 May 2001 16:13:00 -0400
Received: from bitmover.com ([207.181.251.162]:28176 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S136502AbREDUMl>;
	Fri, 4 May 2001 16:12:41 -0400
Date: Fri, 4 May 2001 13:12:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 3ware 6410 RAID 10 performance?
Message-ID: <20010504131239.G6437@work.bitmover.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010504130103.T22922@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20010504130103.T22922@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More data:

the test file is 2GB in size.
When I do a reboot and time the reading of the entire file,
the first time the performance is great, 27MB.
The second time it sucks, 2.7MB.
I tried clearing memory by allocating and pounding on an array of 512MB 
(size of main mem), that clears out memory but the performance still 
sucks.
Unmounting and remounting the drive does not help.

Any ideas?

On Fri, May 04, 2001 at 01:01:03PM -0700, Larry McVoy wrote:
> I'm looking for people who know about the 3ware 6410 driver.  I've got one
> of these and sometimes it goes fast and sometimes it doesn't.  The bad 
> case seems to happen after memory has a lot of cached blocks in it.
> 
> I've tried 2.2.15, 2.4.4, and 2.4.3-ac9 and they all behave pretty similarly.
> 
> I'm most interested in seeing this fixed in the 2.4 series so if there is
> someone who wants to go into a test/debug cycle with me, speak up.  I'd
> really like this thing to work well.
> 
> hardware config:
> 
> K7 @ 750Mhz
> ASUS K7V motherboard
> 512MB
> 4x 3c905
> boot disk on the motherboard
> 4 WD 40GB 7200 drives on one 3ware 6410
> matrox g200 AGP
> -- 
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
