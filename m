Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262501AbSIZLnL>; Thu, 26 Sep 2002 07:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262503AbSIZLnL>; Thu, 26 Sep 2002 07:43:11 -0400
Received: from [203.117.131.12] ([203.117.131.12]:41176 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262501AbSIZLnK>; Thu, 26 Sep 2002 07:43:10 -0400
Message-ID: <3D92F405.3060808@metaparadigm.com>
Date: Thu, 26 Sep 2002 19:48:21 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Mario Mikocevic <mozgy@hinet.hr>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.19pre10aa4 OOPS in ext3 (get_hash_table,  unmap_underlying_metadata)
References: <3D92A1D0.5000203@metaparadigm.com> <3D92B6F3.1428A76A@digeo.com> <3D92BDC8.8080603@metaparadigm.com> <20020926092152.GA32593@danielle.hinet.hr> <3D92D922.5000606@metaparadigm.com> <20020926111301.GA2307@danielle.hinet.hr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/02 19:13, Mario Mikocevic wrote:
> On Thu, Sep 26, 2002 at 05:53:38PM +0800, Michael Clark wrote:
> 
>>I wonder if LVM has anything to do with my problems,
>>you using quotas or LVM?
> 
> 
> Used quotas but disabled it, never used LVM _with_ HBAs on that host
> (per Arjan's advice). LVM _is_ used on local attached SCSI disks though.

I guess this could have something to do with it - bad interaction
between qlogic driver, LVM and ext3 - could explain the corrupt
bufferheads (that's if I read the oops correctly).

~mc

