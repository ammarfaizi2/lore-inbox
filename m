Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSDPJpv>; Tue, 16 Apr 2002 05:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292857AbSDPJpu>; Tue, 16 Apr 2002 05:45:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15880 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292229AbSDPJpt>; Tue, 16 Apr 2002 05:45:49 -0400
Message-ID: <3CBBE42D.7030906@evision-ventures.com>
Date: Tue, 16 Apr 2002 10:43:25 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <Pine.LNX.4.44.0204160215570.389-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> The common thing I use byteswap for is to mount my tivo (kernel 2.1.x)
> drives on my PC (2.4/5.x).  those drives are byteswapped throughout the
> entire drive, including the partition table.
> 
> It sounds as if you are removing this capability, am I misunderstaning you
> or is there some other way to do this? (and duplicating the drive to use
> dd to byteswap is not practical for 100G+)


Same problem as with SCSI disks, which are even more commonly moved
between different system types - please look there for a solution.
BTW.> I hardly beleve that your tivo is containing a DOS partition table -
otherwise the partition table will handle it all autmagically.

