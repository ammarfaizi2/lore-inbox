Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSEHMMU>; Wed, 8 May 2002 08:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSEHMMT>; Wed, 8 May 2002 08:12:19 -0400
Received: from [195.63.194.11] ([195.63.194.11]:59400 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313416AbSEHMMS>; Wed, 8 May 2002 08:12:18 -0400
Message-ID: <3CD9075C.6080505@evision-ventures.com>
Date: Wed, 08 May 2002 13:09:16 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <E175QP9-0001RO-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>RedHat even disables all this chip set specific reporting in theyr
>>public kernels. OK kudzu is using it, but it does not *rely on it*.
> 
> 
> The boot kernel has a lot of it disabled not the main ones.
> 
> 
>>Heck kudzu is running all the time I rebooted my system during
>>developement and nothing ugly did happen.
> 
> 
> I can't speak directly for the Kudzu maintainer but I can say that having
> a sane way to obtain the list of ide devices (all of them not just non 
> pcmcia) and the device bindings/type has been a long standing request.
> 
> If 2.6 breaks a 2.4 installer and nothing else I don't think its a big 
> disaster and the cleanup may well be justified


Well personally I would just love if there where a "go ahead and don't
care about "compatibility" for the following:

Make hdX gone and use the scsi device major/minor number stuff instead.

And then just making the ATA driver looking like if it where some
incapable SCSI would actually reduce tons of code from kudzu and
friends without the need for any adjustment there.


