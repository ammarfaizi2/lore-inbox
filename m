Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130165AbRB1NuQ>; Wed, 28 Feb 2001 08:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130167AbRB1NuH>; Wed, 28 Feb 2001 08:50:07 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:59149 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S130165AbRB1Nt4>; Wed, 28 Feb 2001 08:49:56 -0500
Date: Wed, 28 Feb 2001 05:49:52 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: David Anderson <daveanderson@eudoramail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Can't compilete 2.4.2 kernel
In-Reply-To: <EOFHHHCCDNNKDAAA@shared1-mail.whowhere.com>
Message-ID: <Pine.LNX.4.32.0102280549010.24482-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello David ,
	do a 'ln -s linux-2.4 linux' in directory /usr/src .  Hth ,  JimL

On Wed, 28 Feb 2001, David Anderson wrote:

> Please CC daveanderson@eudoramail.com on your replies - I'm not on the mailing list.
>
> Slackware 7.1
> cd /usr/src
> tar -xvyf linux-2.4.2.tar.bz2
> mv linux linux-2.4
> cd linux-2.4
> make mrproper
> make menuconfig - {selection options, etc.}
> make dep
> make clean
> make bzImage
>
> Get this with bzImage:
>
> gcc -Wall -Wstrict-prototypes -O2- fomit-frame-pointer -o scripts/split-include scripts/split-include.c
> In file included from /usr/include/errno.h:36,
> from scripts/split-include.c:26:
> /usr/include/bits/errno.h:25: linux/errno.h: No such file or directory
> make: *** [scripts/split-include] Error 1
>
>
> THANKS!
>
>
> Join 18 million Eudora users by signing up for a free Eudora Web-Mail account at http://www.eudoramail.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

