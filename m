Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVGYUNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVGYUNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVGYUNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:13:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:63885 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261507AbVGYULD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:11:03 -0400
X-Authenticated: #28678167
Message-ID: <42E547CA.90108@gmx.net>
Date: Mon, 25 Jul 2005 22:12:58 +0200
From: Andreas Baer <lnx1@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local> <42E542D5.3080905@gmx.net> <20050725200330.GA20811@harddisk-recovery.nl>
In-Reply-To: <20050725200330.GA20811@harddisk-recovery.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Erik Mouw wrote:
> On Mon, Jul 25, 2005 at 09:51:49PM +0200, Andreas Baer wrote:
> 
>>Willy Tarreau wrote:
>>
>>>On Mon, Jul 25, 2005 at 03:10:08PM +0200, Andreas Baer wrote:
>>>
>>>>Here I have
>>>>
>>>>       /dev/hda:  26.91 MB/sec
>>>>       /dev/hda1: 26.90 MB/sec    (Windows FAT32)
>>>>       /dev/hda7: 17.89 MB/sec    (Linux EXT3)
>>>>
>>>>Could you give me a reason how this is possible?
>>>
>>>
>>>a reason for what ? the fact that the notebook performs faster than the
>>>desktop while slower on I/O ?
>>
>>No, a reason why the partition with Linux (ReiserFS or Ext3) is always 
>>slower
>>than the Windows partition?
> 
> 
> Easy: Drives don't have the same speed on all tracks. The platters are
> built-up from zones with different recording densities: zones near the
> center of the platters have a lower recording density and hence a lower
> datarate (less bits/second pass under the head). Zones at the outer
> diameter have a higher recording density and a higher datarate.
> 
> 
> Erik
> 

So it has definitely nothing to do with filesystem? I also thought about 
physical reasons because I don't think the hdparm depends on filesystems...
