Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314558AbSEKIYe>; Sat, 11 May 2002 04:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSEKIYd>; Sat, 11 May 2002 04:24:33 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:21138 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S314558AbSEKIYd>; Sat, 11 May 2002 04:24:33 -0400
Message-ID: <3CDCD708.6000208@notnowlewis.co.uk>
Date: Sat, 11 May 2002 09:32:08 +0100
From: mikeH <mikeH@notnowlewis.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Steffl <steffl@bigfoot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: lost interrupt hell - Plea for Help
In-Reply-To: <Pine.LNX.3.96.1020509132713.1987A-100000@pioneer> <200205101112.g4ABCoX29098@Port.imtp.ilyichevsk.odessa.ua> <3CDC3B90.AADE1835@bigfoot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can try compiling without VIA chipset support, but it makes no 
difference.
Now, with the latest prepatches, -ac patches and ide patches, I am 
getting spurious  "8259A interrupt: IRQ7."
all over the place too. Seems like the linux kernel does not play well 
with AMD Cpus + VIA chipsets, which
is a real shame as thats what all my machines are :(

mikeH

Erik Steffl wrote:

>  this is with stable kernel (I tried 2.4.17 and 2.4.18), via config
>option compiled in (I haven't tried without via support in kernel yet,
>I'll try that).
>
>  any ideas? TIA
>
>	erik
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



