Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUG0Rb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUG0Rb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUG0Rb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:31:26 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:64970 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S266489AbUG0RbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:31:14 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Date: Tue, 27 Jul 2004 13:31:13 -0400
User-Agent: KMail/1.6
References: <200407271233.04205.gene.heskett@verizon.net> <20040727142918.GE12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040727142918.GE12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271331.13081.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.53.180] at Tue, 27 Jul 2004 12:31:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 10:29, viro@parcelfarce.linux.theplanet.co.uk 
wrote:
>On Tue, Jul 27, 2004 at 12:33:04PM -0400, Gene Heskett wrote:
>> Greetings everybody;
>>
>> I have now had 4 crashes while running 2.6.8-rc2, the last one
>> requiring a full powerdown before the intel-8x0 could
>> re-establish control over the sound.
>>
>> All have had an initial Opps located in prune_dcache, and were
>> logged as follows:
>> Jul 27 07:58:58 coyote kernel: Unable to handle kernel NULL
>> pointer dereference at virtual address 00000000
>
>... which means that dentry_unused list got corrupted, which doesn't
> really help.  Could you try to narrow it down to 2.6.8-rc1-bk<day>?

And something else that doesn't help, I just found that 2.6.8-rc1 
doesn't have the reverse engineered nforce2 support, so a remake for 
this mobo probably won't fly past the decompression stage.  But 
2.6.8-rc1-mm1 does have it, but under a different xconfig entry.  Its 
building now.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
