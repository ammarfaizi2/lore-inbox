Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317143AbSEXOha>; Fri, 24 May 2002 10:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317147AbSEXOh3>; Fri, 24 May 2002 10:37:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11791 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317143AbSEXOh1>; Fri, 24 May 2002 10:37:27 -0400
Message-ID: <3CEE4136.8000500@evision-ventures.com>
Date: Fri, 24 May 2002 15:33:42 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Vojtech Pavlik <vojtech@suse.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
In-Reply-To: <Pine.SOL.4.30.0205241620440.16894-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Bartlomiej Zolnierkiewicz napisa?:
> Hi!
> 
> I have a very quick look over patch/driver... looks quite ok...

Agreed. And I agree with Vojtech on his view about the
coding style in the old driver (or better the leak of it).
Andrej Panin already noticed as well that it looks more like
perl then C.

Therefore I would rather tend toward the proposal of killing
the old code altogether.

> But it doesn't support multiple controllers. We should add 'unsigned
> long private' to 'ata_channel struct' and store index in the chipset
> table there.
> You can remove duplicate entries from module data table.
> 
> BTW: please don't touch pdc202xx.c I am playing with it...
> 
> greets
> --
> bkz
> 
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

