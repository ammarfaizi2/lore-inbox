Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbUDNPN0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUDNPN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:13:26 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:42122 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264254AbUDNPMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:12:33 -0400
Message-ID: <407D550D.5030003@namesys.com>
Date: Wed, 14 Apr 2004 08:13:17 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Wagland <paul@wagland.net>
CC: Linux mailing list SCSI <linux-scsi@vger.kernel.org>,
       Linux mailing list kernel <linux-kernel@vger.kernel.org>,
       Atul Mukker <atulm@lsil.com>
Subject: Re: reiser4 and megaraid problems with debian 2.6.5
References: <36927C82-8DE0-11D8-A41D-000A95CD704C@wagland.net>
In-Reply-To: <36927C82-8DE0-11D8-A41D-000A95CD704C@wagland.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Wagland wrote:

> Hi all,
>
> I would like to report on a problem that I am having. I am just 
> testing out the new megaraid unified driver, and have been doing some 
> baseline testing with bonnie++.
>
> My problem is that, although reiserfs, ext2, jfs and xfs all work, 
> reiser4 fails with the following error:
> ---
> Can't write block.
> Bonnie: drastic I/O error (write(2)): No such file or directory
> ---
>
> I am using the debian prepared kernel with the debian reiser4 patch. I 
> made a cursory examination of the patch, and it appears to correlate 
> fairly closely with the patch from the namesys site.

In what way does it not correlate?

>
> Given that this works with reiserfs, ext2, jfs and xfs it would appear 
> to be a reiser4 problem, however ext3 also fails, though with a 
> different error, it claims that the disk is full, but it is trying to 
> write a 2 1GB files onto a 2.5GB filesystem, so it should have enough 
> room, and indeed it did even work two or three times out of about 10 
> runs (lots of timing :-). This implies that it might be a megaraid 
> problem. As you can tell, I really have no idea ;-)
>
> I will try playing around tonight with an official kernel and the 
> official reiser4 patch to see if that makes any difference, but would 
> just like to raise this potential problem sooner rather than later.
>
> If I can help debug this situation (I am probably the only person 
> trying this combination :-) please let me know how I should go about it.
>
> Cheers,
> Paul

I don't have the hardware to test it, can you get the error without your 
hardware?

-- 
Hans

