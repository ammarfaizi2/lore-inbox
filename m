Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316758AbSEWPbD>; Thu, 23 May 2002 11:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316759AbSEWPbC>; Thu, 23 May 2002 11:31:02 -0400
Received: from [195.63.194.11] ([195.63.194.11]:39949 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316758AbSEWPbB>; Thu, 23 May 2002 11:31:01 -0400
Message-ID: <3CECFC5B.3030701@evision-ventures.com>
Date: Thu, 23 May 2002 16:27:39 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Gryaznova E." <grev@namesys.botik.ru>
CC: martin@dalecki.de, Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: IDE problem: linux-2.5.17
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

Since this error can be expected to be quite common.
Its an installation error. I will just make the corresponding
error message more intelliglible to the average user:

hda: checksum error on data transfer occurred!

Would have hinted you propably directly at what's wrong.


