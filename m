Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313163AbSEEQLS>; Sun, 5 May 2002 12:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313165AbSEEQLR>; Sun, 5 May 2002 12:11:17 -0400
Received: from [195.63.194.11] ([195.63.194.11]:3086 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313163AbSEEQLQ>;
	Sun, 5 May 2002 12:11:16 -0400
Message-ID: <3CD549FC.4040406@evision-ventures.com>
Date: Sun, 05 May 2002 17:04:28 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Neil Conway <nconway_kernel@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH, IDE corruption, 2.4.18
In-Reply-To: <Pine.SOL.4.30.0205051741140.23671-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Bartlomiej Zolnierkiewicz napisa?:
>>Explanation: some code now differs in the code path concerned, and
>>ide_register_subdriver now only calls ide_dma_check for UDMA drives
>>(previously all DMA drives), but ultimately ide_dma_check still ends up
>>in ide_config_drive_speed, and that's still fuctionally the same as
>>2.4.
> 
> 
> You've got been mistaken by unfortunate name (Martin changed
> name dmaproc() to udma() in 2.5.12).
> Code calls ide_dma_check for chipsets which registerered udma()
> handler (formerly dmaproc()), I think the same 2.4 does.
> 
> btw. udma() name is really misleading,
>      it should be read (u)dma() not udma() :)


It's just an intermediate step before this whole crap get's
trown over ;-).

