Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311264AbSDXJJO>; Wed, 24 Apr 2002 05:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSDXJJN>; Wed, 24 Apr 2002 05:09:13 -0400
Received: from [195.63.194.11] ([195.63.194.11]:29962 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310835AbSDXJJL>; Wed, 24 Apr 2002 05:09:11 -0400
Message-ID: <3CC66794.5040203@evision-ventures.com>
Date: Wed, 24 Apr 2002 10:06:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net>	 <3CC51494.8040309@evision-ventures.com>	  <1019583551.1392.5.camel@turbulence.megapathdsl.net> <1019584497.1393.8.camel@turbulence.megapathdsl.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Miles Lane napisa³:
> On Tue, 2002-04-23 at 10:39, Miles Lane wrote:
> 
>>On Tue, 2002-04-23 at 01:00, Martin Dalecki wrote:
>>
>>>Miles Lane wrote:
>>>
>>>>I should probably add the /proc/ksyms snapshotting stuff to 
>>>>get the module information for you as well.  I hope this 
>>>>current batch of info helps, for starters.
>>>>
>>>>ksymoops 2.4.4 on i686 2.4.7-10.  Options used
>>>>     -v /usr/src/linux/vmlinux (specified)
>>>>     -K (specified)
>>>>     -L (specified)
>>>>     -o /lib/modules/2.5.9/ (specified)
>>>>     -m /boot/System.map-2.5.9 (specified)
>>>
>>>
>>>Looks like the oops came from module code.
>>>Which modules did you use: ide-flappy and ide-scsi are still
>>>in need of the same medication ide-cd got.
>>
>>CONFIG_BLK_DEV_IDESCSI=m
>>CONFIG_SCSI=m
>>CONFIG_BLK_DEV_SD=m
>>CONFIG_BLK_DEV_SR=m
>>CONFIG_CHR_DEV_SG=m
> 
> 
> Hmm.  You probably need this, too.  Sorry for not sending this
> in the first reply.


OK I assume that the oops happens inside the ide-scsi module.
This will be fixed in one of the forthcomming patch sets.

