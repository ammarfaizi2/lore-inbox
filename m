Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSEVOxV>; Wed, 22 May 2002 10:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315553AbSEVOxV>; Wed, 22 May 2002 10:53:21 -0400
Received: from [195.63.194.11] ([195.63.194.11]:44816 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315539AbSEVOwi>; Wed, 22 May 2002 10:52:38 -0400
Message-ID: <3CEBA1DA.2040001@evision-ventures.com>
Date: Wed, 22 May 2002 15:49:14 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Vojtech Pavlik <vojtech@suse.cz>, Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AXZW-0001wM-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>>IOCTL is ineed the way to go to implement such functionality...
>>
>>Yes, the EVIOCSREP ioctl will be the one soon (works for USB keyboards
>>now).
> 
> 
> The KBDRATE ioctl is already supported by all other keyboard drivers and
> used by XFree86....


Yeep. Now I even remember from the dust of my mind,
that there is a *direct mapping*
between terminal settings and ioctl numbers present in
the line discipine code. So ioctl is definitively the way to
go.

BTW.> Did I mention today that the XFree86 people are
indeed the sane ones and always choose the most
UNIX a like and proper interfaces apparently?
!Marvelously good work over a long time out there!
(Well not for font issues, in esp. in an i18n context,
but that's another story...)

