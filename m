Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWFFQdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWFFQdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWFFQdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:33:31 -0400
Received: from mail.tmr.com ([64.65.253.246]:42138 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1750722AbWFFQda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:33:30 -0400
Message-ID: <4485AED0.9030004@tmr.com>
Date: Tue, 06 Jun 2006 12:35:28 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17-rc6
References: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org>	 <20060606120701.GP5132@hjernemadsen.org> <1149607627.30804.5.camel@localhost>
In-Reply-To: <1149607627.30804.5.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Tue, 2006-06-06 at 14:07 +0200, Klaus S. Madsen wrote:
>> Hi,
>>
>> We still experience the NFS client slow down reported by Jakob
>> Østergaard in http://lkml.org/lkml/2006/3/31/82, even with 2.6.17-rc6.
>>
>> Trond Myklebust have created a patch which we have verified solves this
>> problem for 2.6.16, 2.6.17-rc4 and 2.6.17-rc6. The patch is available
>> from http://lkml.org/lkml/2006/4/24/320, and as an attachment to
>> bugzilla bug 6557.
> 
> The patch is already queued up for inclusion in 2.6.18. I'm not planning
> on submitting it for 2.6.17 since it is not a critical bug.

I guess that depends on how much it slows down and how much you depend 
on the speed of NFS. I have all of my machines sharing some local 
binaries and docs, but the files are typically small and the network is 
gigE, so I doubt it will hurt me. On the other hand I do know people 
running workstations with virtually everything NFS mounted, working with 
large image files.

The initial bug report makes it look as if it's about two orders of 
magnitude slower, but doesn't quantify the effect on more common 
sequential access operations.

If this becomes an issue in 2.6.17, I hope it will show up in -stable 
before 2.6.18, the current development cycle is a bit, um, protracted... 
lately.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

