Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293500AbSCAS0M>; Fri, 1 Mar 2002 13:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293493AbSCAS0C>; Fri, 1 Mar 2002 13:26:02 -0500
Received: from [216.66.12.254] ([216.66.12.254]:31934 "HELO
	ep1.elevenprospect.com") by vger.kernel.org with SMTP
	id <S293487AbSCASZq>; Fri, 1 Mar 2002 13:25:46 -0500
Message-ID: <3C7FC7A7.1030405@xblox.net>
Date: Fri, 01 Mar 2002 18:25:43 +0000
From: Matthew Allum <mallum@xblox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020205
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
In-Reply-To: <E16gqxM-0004LV-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its booting !!!!

I tried to build a 2.4.1kernel, but it had problems with my newer ld so 
I tried again with a 2.4.17 following Alans instructions.

I passed mem=6 and it booted. I then expeimented upping this value and 
it still boots when I pass mem=32m ( the actual amount of ram in the 
machine ). So I guess it was just a problem of the box lieing about its 
memory.

Many thanks for all you help, its really appreciated.

  -- Matthew Allum

Alan Cox wrote:

>>Id really appreciate some help on this matter. Theres plenty of these 
>>510's on ebay at the moment going very cheapy ( 100$) and they'd make 
>>nice wireless 'web pads'.
>>
>
>I have a somewhat older beast (Fujitsu Stylistic 1000) which is somewhat
>older and a little lower spec that I've been playing with a fair bit getting
>Xfce + scribble etc running on with no problem.
>
>Generally when you get a crash very early you want to check
>	-CPU type the kernel was built with - your oops isnt an illegal
>	 instruction so thats not it
>	-Disabling APM support
>	-Disabling PnpBIOS support (-ac tree only)
>	-Using mem=fooM where foo is a bit under what is fitted in case
>	 the box lies about memory availability
>
>That generally gets successes. You might also want to do a test boot 
>with mem=6M in case the machine has something funky like a 15-16Mb Vesa
>local bus magic hole in the address map.
>
>Definitely looks a fun toy
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



