Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315831AbSEGObh>; Tue, 7 May 2002 10:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315839AbSEGObe>; Tue, 7 May 2002 10:31:34 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:22449 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S315831AbSEGObb>; Tue, 7 May 2002 10:31:31 -0400
Message-ID: <3CD7E4EB.9040307@antefacto.com>
Date: Tue, 07 May 2002 15:30:03 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <3CD7B8FE.1020505@evision-ventures.com> <3CD7DE62.3060209@antefacto.com> <3CD7D36A.6050209@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> Uz.ytkownik Padraig Brady napisa?:
> 
>> Am I going to have to parse hdparm output?
>> ....
>>  geometry     = 2434/255/63, sectors = 39102336, start = 0
>>
>> Am I going to need hdparm on my embedded system?
> 
> 
> Yes. Or just fsck hardcode the defaults.
> 

hardcode defaults?

Also are the following standard RH7.1 programs going to
need changing?

[padraig@pixelbeat padraig]$ find /sbin /usr/sbin /bin /usr/bin /lib 
/usr/lib /usr/bin/X11/ -xdev -perm +111 | xargs grep -l /proc/ide 
2>/dev/null
/sbin/mkinitrd
/sbin/fdisk
/sbin/sfdisk
/sbin/sndconfig
/usr/sbin/mouseconfig
/usr/sbin/kudzu
/usr/sbin/module_upgrade
/usr/sbin/updfstab
/usr/sbin/glidelink
/usr/sbin/sndconfig
/usr/lib/python1.5/site-packages/_kudzumodule.so
/usr/bin/X11/Xconfigurator

Padraig.

