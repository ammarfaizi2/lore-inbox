Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289310AbSAIJjv>; Wed, 9 Jan 2002 04:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289305AbSAIJjc>; Wed, 9 Jan 2002 04:39:32 -0500
Received: from [195.63.194.11] ([195.63.194.11]:27145 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S288384AbSAIJja>; Wed, 9 Jan 2002 04:39:30 -0500
Message-ID: <3C3C0D34.40402@evision-ventures.com>
Date: Wed, 09 Jan 2002 10:28:20 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Douglas Gilbert <dougg@torque.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.2-pre9 scsi cleanup
In-Reply-To: <3C3BCEB9.B14D20FD@torque.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:

>Martin Dalecki <dalecki@evision-ventures.com>
>
>>The attached patch does the following.
>>
>>1. Clean up some ifdef confusion in do_mount
>>
>>2. Clean up the scsi code to make ppa.c work.
>>
>>3. Clean up some unneccessary unneeded globals from scsi code.
>>
>>4. Make a bit more sure, that the minor() and friends end up in
>>unsigned int's.
>>
>
><snip/>
>
>Martin,
>Please don't post a omnibus SCSI subsystem patch like this.
>
>Most of the code you are changing is actively maintained.
>For example:
>  - scsi mid-level + sr [Jens Axboe]
>  - ppa [Tim Waugh]
>  - sg  [me]
>
>Some of us have grown attached to the way 'cat /proc/scsi/scsi'
>
There where just two drivers for obsolete hardware which actually used this.




