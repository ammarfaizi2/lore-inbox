Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315858AbSEGPNa>; Tue, 7 May 2002 11:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315865AbSEGPNF>; Tue, 7 May 2002 11:13:05 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33550 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315859AbSEGPLC>; Tue, 7 May 2002 11:11:02 -0400
Message-ID: <3CD7DFC9.5080506@evision-ventures.com>
Date: Tue, 07 May 2002 16:08:09 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <Pine.SOL.4.30.0205071653140.29509-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Bartlomiej Zolnierkiewicz napisa?:
> On Tue, 7 May 2002, Roman Zippel wrote:
> 
>>>BTW.> It should indeed take both in to account as far as I can
>>>see.(Despite the fact that I could affort an ATARI I hardly
>>>can find one...)
>>
>>That's not necessary, but I'm only afraid that functionality gets lost,
>>which isn't needed on the latest hardware.
>>
>>bye, Roman
> 
> 
> we should fix atari byte-swapped ide in ata_read() like we do in
> atapi_read() then ide_fix_driveid() will make rest...
> (or I am missing something?)


And the you can move this whole crap out away from
the main code by using the same method as the cris architecture
is using right now. BTW> The only thing missing is
the fact that there are currently two different
functions reading the id information there.


