Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSEGOEI>; Tue, 7 May 2002 10:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSEGOEH>; Tue, 7 May 2002 10:04:07 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:49328 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S315451AbSEGOEH>; Tue, 7 May 2002 10:04:07 -0400
Message-ID: <3CD7DE62.3060209@antefacto.com>
Date: Tue, 07 May 2002 15:02:10 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <3CD7B8FE.1020505@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> Mon May  6 13:29:44 CEST 2002 ide-clean-56
> 

[snip]

> OK. After realizing the simple fact that quite a lot of low level 
> hardware manipulating ioctls may require assistance in usage from 
 > proper logic which is *very* unlikely to be implemented in a bash
 > (for me preferable still ksh) I have made my mind up.
> 
>     /proc/ide will be nuked.

Please consider this carefully, especially the read only bits.
One particular thing I use a lot is: /proc/ide/hda/capacity
Will there be another interface easily usable by scripts
to get this information?

Am I going to have to parse hdparm output?
....
  geometry     = 2434/255/63, sectors = 39102336, start = 0

Am I going to need hdparm on my embedded system?

Padraig.

