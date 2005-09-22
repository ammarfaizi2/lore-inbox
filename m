Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbVIVP5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbVIVP5G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbVIVP5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:57:06 -0400
Received: from magic.adaptec.com ([216.52.22.17]:1467 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030422AbVIVP5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:57:04 -0400
Message-ID: <4332D447.6050503@adaptec.com>
Date: Thu, 22 Sep 2005 11:56:55 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: Rolf Offermanns <roffermanns@sysgo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linus GIT tree disappeared from http://www.kernel.org/git/?
References: <200509221514.44027.roffermanns@sysgo.com> <20050922133228.GB26438@flint.arm.linux.org.uk> <200509221131.41838.gene.heskett@verizon.net>
In-Reply-To: <200509221131.41838.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 15:57:02.0926 (UTC) FILETIME=[45EBA6E0:01C5BF8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/05 11:31, Gene Heskett wrote:
> On Thursday 22 September 2005 09:32, Russell King wrote:
> 
>>On Thu, Sep 22, 2005 at 03:14:43PM +0200, Rolf Offermanns wrote:
>>
>>>Maybe I am dreaming, but I could have sworn it has been there
>>>yesterday...
>>
>>It seems that kernel.org hasn't finished updating the mirrors yet -
>>and it seems to be taking hours.  Unfortunately, this has left Linus'
>>public git tree in an inconsistent state.
>>
>>I won't speculate why stuff is so slow - that's for the kernel.org
>>admins to work out.
> 
> 
> I have made 4 passes at re-grabbing the 2.6.14-rc2 with git, and each
> time it exits with an error, but the tree it grabs looks to be ok. 
> Somethings a bit wonky here.
> 
> The error:
> 
> tags/v2.6.14-rc2
> 
> sent 563 bytes  received 2778 bytes  954.57 bytes/sec
> total size is 779  speedup is 0.23
> rsync: link_stat
> "/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/info/alternates"
> (in pub) failed: No such fi
> le or directory (2)
> rsync error: some files could not be transferred (code 23) at
> main.c(812)

The reason is that all metadata, tags, etc is there.
See for yourself:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tags

	Luben

