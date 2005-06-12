Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVFLTp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVFLTp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFLT1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:27:45 -0400
Received: from [85.8.12.41] ([85.8.12.41]:37301 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262666AbVFLSPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 14:15:54 -0400
Message-ID: <42AC7BD4.9040906@drzeus.cx>
Date: Sun, 12 Jun 2005 20:15:48 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: MMC ioctl or sysfs interface?
References: <42A83F59.7090509@drzeus.cx>	 <101040.57feb9cd101d268ffd2ffe2d314867d3.ANY@taniwha.stupidest.org>	 <42A9FF79.1010003@drzeus.cx> <1118444435.5213.72.camel@localhost.localdomain>
In-Reply-To: <1118444435.5213.72.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Gwe, 2005-06-10 at 22:00, Pierre Ossman wrote:
>  
>
>>>IDE disks can do this too --- is it the same interface?
>>>      
>>>
>>No. ATA and MMC are very different protocols.
>>    
>>
>
>It would be good to have the same ioctls on both block devices or sysfs
>files however.
>  
>

I wasn't aware that you could do ioctl on sysfs nodes. I guess I'll have
to dig a bit deeper in the documentation/code.

As for keeping the same ioctl. If the current ioctls are similar enough
then I don't see why not. The userspace tools might need changing though
since all ATA ioctls won't be available. What tool is used for locking
an ATA drive? And is there some documentation detailing the lock
commands and related ioctls so I can compare with what I'm trying to do?

Rgds
Pierre

