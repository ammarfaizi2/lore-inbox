Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315591AbSEJMDR>; Fri, 10 May 2002 08:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315597AbSEJMDR>; Fri, 10 May 2002 08:03:17 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:61914 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S315591AbSEJMDQ>; Fri, 10 May 2002 08:03:16 -0400
Message-ID: <3CDBB686.5080709@antefacto.com>
Date: Fri, 10 May 2002 13:01:10 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205070953420.2509-100000@home.transmeta.com> <3CD8DAA2.6080907@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> Uz.ytkownik Linus Torvalds napisa?:
> 
>> But there is definitely a potential backwards-compatibility-issue.
> 
> 
> Linus - there are no backward compatibility issues here.
> No single application from my system does mess with /proc/ide.
> They showed you a list of programs which use /proc and not a list
> of programs which use anything out of /proc/ide...

To be thorough, I greped for /proc/ide not just /proc,
the exact command was:

find /sbin /usr/sbin /bin /usr/bin /lib /usr/lib /usr/bin/X11/ -xdev 
-perm +111 | xargs grep -l /proc/ide 2>/dev/null

Padraig.

