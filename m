Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVAaLoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVAaLoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 06:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVAaLoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 06:44:01 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:20650 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261154AbVAaLn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 06:43:58 -0500
Message-ID: <41FE2814.9030503@tiscali.de>
Date: Mon, 31 Jan 2005 13:44:04 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: My System doesn't use swap!
References: <41FE1B4B.2060305@tiscali.de> <200501311157.10932.mbuesch@freenet.de>
In-Reply-To: <200501311157.10932.mbuesch@freenet.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:

>Quoting Matthias-Christian Ott <matthias.christian@tiscali.de>:
>  
>
>>Hi!
>>I have mysterious Problem:
>>90 % of my Ram are used (340 MB), but 0 Byte of my Swap (2GB) is used 
>>and about about 150 MB are swappable.
>>
>>[matthias-christian@iceowl ~]$ free
>>             total       used       free     shared    buffers     cached
>>Mem:        383868     362176      21692          0         12     208956
>>-/+ buffers/cache:     153208     230660
>>    
>>
>                                    ^^^^^^
>You have ~230M of 380M free.
>Nothing mysterious here.
>
>  
>
>>Swap:      2097136          0    2097136
>>
>>[matthias-christian@iceowl ~]$ cat /kernel-2.6.10-rc2-ott/config
>>[..]
>>CONFIG_SWAP=y
>>[..]
>>CONFIG_X86_BSWAP=y
>>[..]
>>
>>[matthias-christian@iceowl ~]$ dmesg
>>[..]
>>Adding 2097136k swap on /dev/discs/disc0/part2.  Priority:-1 extents:1
>>[..]
>>
>>Matthias-Christian Ott
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>>    
>>
>
>  
>
Ok maybe I wasn't able to read the /free/ output correctly, but why is 
no swap used (more than 60% ram are used)?

Matthias-Christian Ott
