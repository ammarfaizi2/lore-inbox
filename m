Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVCYWj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVCYWj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVCYWiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:38:18 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:599 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261867AbVCYWb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:31:57 -0500
Message-ID: <42449155.4040700@mesatop.com>
Date: Fri, 25 Mar 2005 15:31:49 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm3 (cannot read cd-rom, 2.6.12-rc1 is OK)
References: <20050325002154.335c6b0b.akpm@osdl.org>	<42446B86.7080403@mesatop.com>	<424471CB.3060006@mesatop.com>	<20050325122433.12469909.akpm@osdl.org>	<4244812C.3070402@mesatop.com> <20050325134903.6862718f.akpm@osdl.org>
In-Reply-To: <20050325134903.6862718f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> 
>>>>I found a few more minutes to test two more kernels.  The problem
>>>>first occured with 2.6.12-rc1-mm2:
>>>>
>>>>2.6.12-rc1     reads the cd-rom OK as reported earlier
>>>>2.6.12-rc1-mm1 also reads the cd-rom OK
>>>>2.6.12-rc1-mm2 broken same as -mm3 described as above
>>>>2.6.12-rc1-mm3 broken as reported earlier
>>>
>>>
>>>Are you really really sure about that?  -mm3 included both the bk-ide-dev
>>>tree and the isofs changes.  2.6.12-rc1-mm2 had neither.
>>>
>>
>>Just to be really really sure, I repeated the tests.  I even checked
>>that the image/label combination in /etc/lilo.conf was what I intended,
>>but the uname -r should show what's what.
>>
>>Same results, -mm2 broken, and -mm1 reads the disk.  I even tried
>>other CD's just to make sure I didn't have something weird.  Same results.
> 
> 
> OK, thanks.
> 
> It would be interesting to copy a CD to hard disk (under -mm1) and see if
> it works OK with the loopback driver.
> 
> Also, boot into -mm2 and do a `cmp' of the cdrom with the image which is on
> hard-disk.
> 
> This should help us work out whether it's isofs, the driver, the VFS or
> whatever.
> -

It seems that I've run out of time here today.  If this is still an issue
after the weekend, I'll do the above tests.

Until then, Happy Easter.

Steven
