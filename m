Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSEIM5I>; Thu, 9 May 2002 08:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSEIM5H>; Thu, 9 May 2002 08:57:07 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20498 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293632AbSEIM5G>; Thu, 9 May 2002 08:57:06 -0400
Message-ID: <3CDA6363.2050108@evision-ventures.com>
Date: Thu, 09 May 2002 13:54:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hdreg.h
In-Reply-To: <UTC200205082345.g48NjZX24244.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Andries.Brouwer@cwi.nl napisa³:
> Linus, Martin:
> 
> People complain that fdisk doesn't compile under 2.5.14
> because hdreg.h has acquired stuff that cannot be included
> from userspace. Will release util-linux 2.11r later tonight
> with a local copy.
> But now that I look at this file: it still contains
> struct hd_big_geometry and HDIO_GETGEO_BIG.
> Please remove them.


If fdisk doesn't use it. I will take your patch immediately.
One arbitrary ioctl which was introduced ad hock less. :-).

