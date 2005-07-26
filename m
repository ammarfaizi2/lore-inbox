Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVGZNL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVGZNL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVGZNL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:11:56 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:37386 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261749AbVGZNLv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:11:51 -0400
Message-ID: <42E6378E.6050701@tmr.com>
Date: Tue, 26 Jul 2005 09:15:58 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gbakos@cfa.harvard.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: elvtune with 2.6 kernels (under FC3)
References: <Pine.SOL.4.58.0507251629130.2429@titan.cfa.harvard.edu>
In-Reply-To: <Pine.SOL.4.58.0507251629130.2429@titan.cfa.harvard.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaspar Bakos wrote:
> Hi,
> 
> I am cc-ing this to the kernel list, a i have the suspicion that it may
> be a kernel related feature.
> 
> --------------
> I noticed that elvtune does not work on FC3 with a 2.6.12.3
> (self-compiled, pristine) kernel. I also tried it with other 2.6.* kernels.
> 
> elvtune /dev/sde
> ioctl get: Invalid argument
> 
> In fact, I get the same message for all disks, either those on a 3ware
> controller, or SATA disks directly attached to the motherboard.
> The hw is a dual opteron mb with 4Gb RAM.
> 
> Did this command become obsoleted?
> Is there alternativ?

Not that I ever found. You can play with values in 
/sys/block/{device}/queue or wherever you have your sysfs mounted.
Not a great user interface, but at least you can play.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
