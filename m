Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316324AbSEZTcg>; Sun, 26 May 2002 15:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316327AbSEZTcf>; Sun, 26 May 2002 15:32:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316324AbSEZTcf>;
	Sun, 26 May 2002 15:32:35 -0400
Message-ID: <3CF13911.D5C0EA3E@zip.com.au>
Date: Sun, 26 May 2002 12:35:45 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: zlatko.calusic@iskon.hr
CC: linux-kernel@vger.kernel.org, cr@sap.com
Subject: Re: 2.5.18 / ext3 / oracle trouble
In-Reply-To: <877klr2ank.fsf@atlas.iskon.hr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic wrote:
> 
> Hi!
> 
> After lots of testing, I can say that 2.5.18 works great in all three
> modes of ext3 for all but one purpose. Oracle database still gets
> corrupted during insert load. More precisely, online redo log gets
> corrupted, database panics and restore is in order.
> 
> This leads me to thinking that there's something wrong with sysv
> shared memory in 2.5.x. Although the problem could also be in fsync()
> or swap_out() & co. paths, it's yet to be discovered.
> 
> It could also be that journaled mode helps the trouble, and it could
> be that some swapping makes it more certain, but none of these two
> facts are proved for sure. Take it as an observation.
> 
> Christoph, I don't know if you're still taking care of shmem in 2.5.x,
> so take my apologies if you didn't want to see this email.
> 

Are you able to try it on ext2?

Thanks.

-
