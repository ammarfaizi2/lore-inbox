Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317593AbSFMMBx>; Thu, 13 Jun 2002 08:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317596AbSFMMBw>; Thu, 13 Jun 2002 08:01:52 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28679 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317593AbSFMMBv> convert rfc822-to-8bit; Thu, 13 Jun 2002 08:01:51 -0400
Message-ID: <3D0889AA.4080002@evision-ventures.com>
Date: Thu, 13 Jun 2002 14:01:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <5.1.0.14.2.20020610114308.09306358@mail1.qualcomm.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Maksim (Max) Krasnyanskiy napisa³:
> Hi Martin,
> 
> How about replacing __FUNCTION__ with __func__ ?
> GCC 3.x warns that __FUNCTION__ is obsolete and will be removed.
> Here is how I did it in Bluetooth code:
>         #define BT_DBG(fmt, arg...)  printk(KERN_INFO "%s: " fmt "\n" , 
> __func__ , ## arg)
> no more warnings from gcc.

At the paces where there are wrapper macros this would
make sense indeed. Otherwise - well not worth the trouble.



