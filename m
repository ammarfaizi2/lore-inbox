Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265710AbUBPRqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265713AbUBPRqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:46:04 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:7689 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265710AbUBPRqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:46:00 -0500
Message-ID: <403103A2.1040709@techsource.com>
Date: Mon, 16 Feb 2004 12:53:38 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Walt H <waltabbyh@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1,
 etc.
References: <200402141016.51205.waltabbyh@comcast.net>
In-Reply-To: <200402141016.51205.waltabbyh@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Walt H wrote:
> On Thu, Feb 12, 2004 at 06:32:31PM -0500, Timothy Miller wrote:
> 
> 
>>For writes, iozone found an upper bound of about 10megs/sec, which is 
>>abysmal.  Typically, I'd expect writes to be faster (on a single drive) 
>>than reads, because once the write is sent, you can forget about it. 
>>You don't have to wait around for something to come back, and that 
>>latency for reads can hurt performance.  The OS can also buffer writes 
>>and reorder them in order to improve efficiency.
> 
> 
> I'm joining this thread rather late, so perhaps I missed something. What 
> hardware is the test being ran on? I have an AMD MPX based setup which 
> suffers from a chipset bug which effectively limits writes to ~25MB/sec to 
> devices connected via the 768 southbridge. Maybe something similar with your 
> hardware?

Athlon 2800+
Via KT400 chipset (ABIT KD7, I believe)
WD1200JB (Western Digital 120gb)
3ware 7000-2 as RAID1
Latest Red Hat 2.4.20-?? kernel


My wife's computer has the ABIT board with the KT333 and the same drive, 
but not RAID.  SiSoft SANDRA reports 39 megs/sec for writes to an NTFS 
volume.


Right now, I'm thinking the bottleneck may be the 3ware.

