Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291397AbSBNKFZ>; Thu, 14 Feb 2002 05:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291402AbSBNKFM>; Thu, 14 Feb 2002 05:05:12 -0500
Received: from [195.63.194.11] ([195.63.194.11]:28174 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291397AbSBNKEu>; Thu, 14 Feb 2002 05:04:50 -0500
Message-ID: <3C6B8BA7.7030002@evision-ventures.com>
Date: Thu, 14 Feb 2002 11:04:23 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <3C69750E.8BA2C6AB@zip.com.au> <3C6A4449.3030703@evision-ventures.com> <3C6AB5D2.A7D665FE@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Martin Dalecki wrote:
>
>>>I suspect that if we remove these, we'll one day end up putting them back.
>>>It is appropriate that we be able to control readahead characteristics
>>>on a per-device and per-technology basis.
>>>
>>You are missing one simple thing: The removed values doen't control
>>ANYTHING!
>>
>
>The file_readahead setting works as expected and as desired.  Or at
>least it did a few weeks ago.
>
The few weeks ago thing matters. It doesn't any longer.


