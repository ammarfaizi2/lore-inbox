Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVJ2OxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVJ2OxX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVJ2OxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:53:23 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:9355 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751177AbVJ2OxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:53:22 -0400
Date: Sat, 29 Oct 2005 10:53:21 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: building 2.4.31 for a non-smp system
In-reply-to: <20051029121019.7A3C51071FC@mail.local.net>
To: linux-kernel@vger.kernel.org
Message-id: <200510291053.21417.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20051029121019.7A3C51071FC@mail.local.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 07:57, Per Jessen wrote:
>On Sat, 29 Oct 2005 13:34:02 +0200, Per Jessen wrote:
>>>  Please send:
>>>  - your .config
>>
>>Attached.
>
>I think you can ignore this report - I've just configured the build
from
>scratch, and everything is working fine.  For the previous build(s) I
> had used the .config from the .23 kernel - I thought that would be OK,
> but it obviously wasn't.
>
>
>Per Jessen, Zurich

Did you do a 'make oldconfig' first?  This is very important when
keeping config continuity from kernel build to kernel build.

That should have asked you some questions about how to set any new
options, and removed any old, now invalid ones while maintaining the
working options you had set in the .23 .config.  Thats all done
automaticly by my buildit script, which I edit to give it the old
version to reference, and what new version I'm building next.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Free OpenDocument reader/writer/converter download:
http://www.openoffice.org
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

