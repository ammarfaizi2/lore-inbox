Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313974AbSDQAMA>; Tue, 16 Apr 2002 20:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313975AbSDQAL7>; Tue, 16 Apr 2002 20:11:59 -0400
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:61646 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S313974AbSDQAL6>; Tue, 16 Apr 2002 20:11:58 -0400
Message-ID: <3CBCBD56.8010700@ngforever.de>
Date: Tue, 16 Apr 2002 18:09:58 -0600
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.9+) Gecko/20020405
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Peter Nikolic <p.nikolic@btinternet.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE Problems
In-Reply-To: <E16xco4-00019Z-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>end_request: I/O error, dev 03:03 (hda), sector 942192
>>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>>hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
> You have a bad block on /dev/hda3

I thought once I had one, but it was my old reiserfs. This was in Linux 
2.4.8 or such, when reiserfs journal recovery drove my drive mad. I kept 
looking for a bad block, but there was none. I used a newer reiserfs 
release and things went...
But a bad block is still quite likely.

Regards,
Thunder
-- 
Thunder from the hill.
Citizen of our universe.

