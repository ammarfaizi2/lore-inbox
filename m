Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265367AbRFVIPq>; Fri, 22 Jun 2001 04:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbRFVIPg>; Fri, 22 Jun 2001 04:15:36 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:45788 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S265367AbRFVIP1>; Fri, 22 Jun 2001 04:15:27 -0400
Message-ID: <3B32FEA9.1070105@AnteFacto.com>
Date: Fri, 22 Jun 2001 09:15:37 +0100
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Bjorn Wesen <bjorn@sparta.lu.se>, linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
In-Reply-To: <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se> <21093.988364178@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

>bjorn@sparta.lu.se said:
>
>> you could try using jffs2 on a RAM-simulated MTD partition. i think
>>that would work but i have not tried it..
>>
>
>It works. Most of the early testing and development was done on it. It 
>wouldn't give you dynamic sizing like ramfs though. 
>
>It would be nice to have a version of ramfs which compresses pages into a 
>separate backing store when they're unused. Shame somebody nicked the name 
>'cramfs' for something else, really :)
>

Hmm must look into getting ramfs working with
http://linuxcompressed.sourceforge.net/
seems like the best of both worlds.

Padraig


