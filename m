Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317546AbSHHJgZ>; Thu, 8 Aug 2002 05:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317561AbSHHJgZ>; Thu, 8 Aug 2002 05:36:25 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33803 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317546AbSHHJgY>; Thu, 8 Aug 2002 05:36:24 -0400
Message-ID: <3D523B25.5080105@evision.ag>
Date: Thu, 08 Aug 2002 11:34:29 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: martin@dalecki.de, "Adam J. Richter" <adam@yggdrasil.com>,
       alan@lxorguk.ukuu.org.uk, Andries.Brouwer@cwi.nl, johninsd@san.rr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
References: <Pine.LNX.4.44.0208081129420.3210-100000@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Ingo Molnar napisa?:
> On Thu, 8 Aug 2002, Marcin Dalecki wrote:
> 
> 
>>>| the boot loader (read.S).  Currently, the kernel value is given precedence;
>>>| I am seriously reviewing this issue.
>>>
>>>	I just wonder if this is the problem that you are experiencing
>>>rather than anything that was new in 2.5.29.
>>
>>Yes.
> 
> 
> folks, please keep in mind that this is a system that i just dont
> reconfigure at whim. It's a proven, known system i use for testing and
> nothing else. Suddenly it stopped working somewhere between 2.5.20 and
> 2.5.30. No lilo upgrade, no nothing, 2 years old binaries:
> 
>   [mingo@a mingo]$ ls -l /sbin/lilo
>   -rwxr-xr-x    1 root     root        59324 Aug 23  2000 /sbin/lilo

Yes sure. It is simply a very old bug in lilo, which the kernel worked
around and did fight against in a diallectic way.

