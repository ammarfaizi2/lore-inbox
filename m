Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312370AbSDJKOM>; Wed, 10 Apr 2002 06:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312379AbSDJKOL>; Wed, 10 Apr 2002 06:14:11 -0400
Received: from [195.63.194.11] ([195.63.194.11]:55825 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312370AbSDJKOK>; Wed, 10 Apr 2002 06:14:10 -0400
Message-ID: <3CB401ED.70708@evision-ventures.com>
Date: Wed, 10 Apr 2002 11:12:13 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] IDE TCQ #2
In-Reply-To: <20020409124417.GK25984@suse.de> <3CB3FDF7.6010505@evision-ventures.com> <20020410095829.GG2485@suse.de> <3CB40036.7010504@evision-ventures.com> <20020410100919.GH2485@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>>I'm already running 2.5.8-pre3 (which appears to include ide-29b,
>>>right?) + ide-tcq here, so you should probably not waste any effort on
>>>that :-)
>>
>>Well than I will have to basically redo all the
>>stuff I did in between... like for example nuking the
>>number of parameters to ata_taskfile()... :-(.
> 
> 
> Ok, go ahead with the merge then and keep your changes. I'll just diff
> #2 -> current and apply that to whatever shows up in the next kernel.

At least I can tell you now that ide_wait_taskfile as well
ide_raw_taskfile are not far from beeing only history right now :-).

