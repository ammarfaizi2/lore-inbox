Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSHGV2A>; Wed, 7 Aug 2002 17:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSHGV2A>; Wed, 7 Aug 2002 17:28:00 -0400
Received: from zianet.com ([204.134.124.201]:33183 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S312938AbSHGV17>;
	Wed, 7 Aug 2002 17:27:59 -0400
Message-ID: <3D51940A.60805@zianet.com>
Date: Wed, 07 Aug 2002 15:41:30 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020802
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
References: <Pine.LNX.4.44.0208072149190.3705-100000@pc40.e18.physik.tu-muenchen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I just tried it with a 3GB file transfer, still
held up.  Only thing I see different from what you have is
I have it running on the Thunder 2468, I have one more 7850,
and its just stock 2.4.19.  I think the big factor would be the 2466
vs the 2468 however.  I believe they both have the same chipset.

Steve

Roland Kuhn wrote:

>On Wed, 7 Aug 2002 kwijibo@zianet.com wrote:
>
>  
>
>>I just tried this on a dual Athlon box with two 7850's in it
>>and a 3C996B-T as well.  Lucky for me though, this
>>error did not show up.  I transfered/received two 800MB files
>>to the RAID and it held up ok.  What driver version are you
>>using? Or even kernel version.
>>
>>    
>>
>Tyan Tiger (2466) v1.02
>3ware 7850 (software revision 7.5)
>3C996B-T (runs with 33Mhz, don't know why)
>2*Athlon MP 1900+
>kernel 2.4.19 vanilla
>
>The script to reproduce this copies simultanously from the disk to the 
>network and back. Be sure to really hit the disk: 800MB did not show the 
>error in my case, if all was in RAM.
>
>Ciao,
>					Roland
>
>+---------------------------+-------------------------+
>|    TU Muenchen            |                         |
>|    Physik-Department E18  |  Raum    3558           |
>|    James-Franck-Str.      |  Telefon 089/289-12592  |
>|    85747 Garching         |                         |
>+---------------------------+-------------------------+
>
>
>
>  
>



