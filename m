Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289673AbSAOVGU>; Tue, 15 Jan 2002 16:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289671AbSAOVGK>; Tue, 15 Jan 2002 16:06:10 -0500
Received: from quark.didntduck.org ([216.43.55.190]:60683 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S289670AbSAOVFz>; Tue, 15 Jan 2002 16:05:55 -0500
Message-ID: <3C4499A3.781E5A85@didntduck.org>
Date: Tue, 15 Jan 2002 16:05:39 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zaitsev <pz@spylog.ru>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3.5G user space speed
In-Reply-To: <16247691406.20020115234737@spylog.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev wrote:
> 
> Hello Linux,
> 
>   2.4.xaa Series as well as  SuSE kernels have  3.5G userspace option,
>   which seems to be quite useful, therefore I see it's not included
>   is stock kernel for some reasons. Also I've heard this
>   configuration may have some performance problems.
> 
>   Can anyone comment on this topic ?
> 
>   I need large amount of address space for my application but I also
>   need to get as much I/O performance as it's possible, so I can switch
>   to 3.0/1.0 memory distribution if it will benefit here.

You can't have it both ways with the x86 (speed vs. large userspace). 
Kernel 2.5 may help a bit here because changes were made to allow DMA
from all memory (subject to card limitations), lessening the burden for
direct-mapped memory.  Otherwise you'll need to move to a 64-bit arch.

--

				Brian Gerst
