Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUBVCkm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbUBVCkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:40:41 -0500
Received: from adsl-63-194-240-129.dsl.lsan03.pacbell.net ([63.194.240.129]:35077
	"EHLO mikef-fw.mikef-fw.matchmail.com") by vger.kernel.org with ESMTP
	id S261648AbUBVCkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:40:13 -0500
Message-ID: <4038168C.1000404@matchmail.com>
Date: Sat, 21 Feb 2004 18:40:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <4038014E.5070600@matchmail.com> <20040222012033.GC703@holomorphy.com> <40380DE2.4030702@matchmail.com> <20040222021710.GD703@holomorphy.com>
In-Reply-To: <20040222021710.GD703@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> William Lee Irwin III wrote:
> 
>>>Similar issue here; I ran out of filp's/whatever shortly after booting.
> 
> 
> On Sat, Feb 21, 2004 at 06:03:14PM -0800, Mike Fedyk wrote:
> 
>>So Nick Piggin's VM patches won't help with this?
> 
> 
> I think they're in -mm, and I'd call the vfs slab cache shrinking stuff
> a vfs issue anyway because there's no actual VM content to it, apart
> from the code in question being driven by the VM.

Hmm, that's news to me.  Maybe that's a newer patch.  I haven't been 
reading the list much for the last month or so...

Nick had a patch that was supposed to help 2.6 with low memory 
situations to bring it on a par with 2.4 in that respect.  ISTR "active 
recycling" being mentioned about it...

I also did a
find / -xdev -type f -exec cat "{}" \; > /dev/null 2>&1
with no swap and my page cache didn't get any bigger and slab didn't 
shrink. :(

Is there anything in 2.6.3 in respect to IDE, MD Raid{1,5}, knfsd, or 
athlons I should worry about in upgrading from 2.6.1?

Thanks,

Mike

