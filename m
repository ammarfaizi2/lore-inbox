Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136487AbRD3JWV>; Mon, 30 Apr 2001 05:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136488AbRD3JWL>; Mon, 30 Apr 2001 05:22:11 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:41991 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S136487AbRD3JWE>; Mon, 30 Apr 2001 05:22:04 -0400
Date: Mon, 30 Apr 2001 02:22:00 -0700
Message-Id: <200104300922.f3U9M0T15608@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <20010429011604.A976@home.ds9a.nl>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Apr 2001 01:16:04 +0200, bert hubert <ahu@ds9a.nl> wrote:
> On Sat, Apr 28, 2001 at 02:21:29PM -0700, Ion Badulescu wrote:
>> Hi Alan,
>> 
>> Over the last week I've tried to upgrade a 4-CPU Xeon box to 2.2.19, but 
>> the it keeps locking up whenever the disks are stresses a bit, e.g. when 
>> updatedb is running. I get the following messages on the console:
>> 
>> wait_on_bh, CPU 1:
>> irq:  1 [1 0]
>> bh:   1 [1 0]
>> <[8010af71]>
> 
> Obvious question is, which compiler.

These are rh62 systems, the compiler is egcs-1.1.2. So that's not it.

I'd be willing to do the binary search through the 2.2.19pre series,
but I'd rather avoid it if it's a known bug. It's pretty painful, both
for myself and for the real users of this box, to go through the pains
of 10-20 cycles of reboot-crash-fsck_3_large_disks...

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
