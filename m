Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUHWOjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUHWOjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 10:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUHWOjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 10:39:35 -0400
Received: from mailer.nec-labs.com ([138.15.108.3]:13927 "EHLO
	mailer.nec-labs.com") by vger.kernel.org with ESMTP id S264697AbUHWOjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 10:39:32 -0400
Message-ID: <412A01AC.5020108@nec-labs.com>
Date: Mon, 23 Aug 2004 10:39:40 -0400
From: Lei Yang <leiyang@nec-labs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Lee Revell <rlrevell@joe-job.com>, Sam Ravnborg <sam@ravnborg.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
References: <4127A15C.1010905@nec-labs.com>  <20040821214402.GA7266@mars.ravnborg.org> <4127A662.2090708@nec-labs.com>  <20040821215055.GB7266@mars.ravnborg.org>  <4127B49A.6080305@nec-labs.com> <1093121824.854.167.camel@krustophenia.net> <4129FAC8.3040502@nec-labs.com> <Pine.LNX.4.53.0408231018001.7732@chaos>
In-Reply-To: <Pine.LNX.4.53.0408231018001.7732@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2004 14:39:32.0594 (UTC) FILETIME=[00F00D20:01C4891F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> Do `depmod -e test.ko` to see what it's complaining about. You
> can see all the symbols by using `nm`. Try it. Your code
> probably didn't define the necessary stuff to make a module.
> You need to look at a typical module (driver) that comes with the
> kernel. Just find one of the shortest ".c" files in the driver
> tree.

Thanks! I did less /var/log/messages, and got the unknown symbols
Unknown symbol __divsf3
Unknown symbol __fixsfsi
Unknown symbol __subsf3
Unknown symbol __floatsisf
Unknown symbol __mulsf3
Unknown symbol __gesf2
Unknown symbol __addsf3

However, I don't know what those symbols are :( I am a bit worried that 
maybe I've done something that is not supported by the kernel, like 
left-shift 16 bits of an int, or floating operations.

Any hints?

Thanks a lot!
Lei

> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 
