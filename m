Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276132AbRJGDZc>; Sat, 6 Oct 2001 23:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276073AbRJGDZX>; Sat, 6 Oct 2001 23:25:23 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:18447 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S276060AbRJGDZL>; Sat, 6 Oct 2001 23:25:11 -0400
Message-ID: <3BBFCB29.9B7BB17F@zip.com.au>
Date: Sat, 06 Oct 2001 20:25:29 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob McElrath <mcelrath@draal.physics.wisc.edu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.11-pre4, extremely long umount times
In-Reply-To: <20011006202928.C749@draal.physics.wisc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob McElrath wrote:
> 
> I'm running 2.4.11-pre4 with the ext3 patch and Andrew Morton's low-latency
> patch on an alpha LX164.
> 
> umount times are extremely long (> 30 minutes) for both ext2 and ext3
> filesystems, though they eventually succeed.
> 
> Is this a known problem?
> 

Nope.  It's possible to get swapoff durations of many minutes,
but I don't think similar problems with unmount have been reported.
Is there any disk activity?  ps and top output?  Any theories?

BTW: I'm faintly surprised to hear that ext3 actually works in
2.4.11-pre4.  Quite a lot of things with which ext3 has an intimate
relationship were changed....
