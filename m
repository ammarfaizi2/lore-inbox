Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263297AbVFXRTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbVFXRTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 13:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbVFXRR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 13:17:26 -0400
Received: from kirby.webscope.com ([204.141.84.57]:33754 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S263366AbVFXRMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 13:12:39 -0400
Message-ID: <42BC3EFE.5090302@m1k.net>
Date: Fri, 24 Jun 2005 13:12:30 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Peters <frank.peters@comcast.net>
CC: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
References: <20050624113404.198d254c.frank.peters@comcast.net>	<42BC306A.1030904@m1k.net> <20050624125957.238204a4.frank.peters@comcast.net>
In-Reply-To: <20050624125957.238204a4.frank.peters@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am cc'ing your message to Vojtech Pavlik, the INPUT DRIVERS kernel 
maintainer.

Vojtech, I figured these should be sent to you.  If I am wrong, please 
redirect them to the correct person / list and let us know.

Thank you.

Frank Peters wrote:

>On Fri, 24 Jun 2005 12:10:18 -0400
>Michael Krufky <mkrufky@m1k.net> wrote:
>
>  
>
>>I am having the same problem with my Shuttle FT61 motherboard, although 
>>I have not tried to disable ACPI... Until now I thought I just had a 
>>faulty keyboard, as my method to fix this was to unplug the keyboard and 
>>plug it back in after bootup.  When this happens, I see this in dmesg as 
>>the last line:
>>
>>input: AT Translated Set 2 keyboard on isa0060/serio0
>>
>>I am also having problems with my AUX mouse, as seen in message
>>
>>Subject: 2.6.12-rc5-mm1 breaks serio: i8042 AUX port
>>
>>Frank, are you having problems with your ps/2 mouse port as well?
>>
>>    
>>
>
>I am so glad that you asked this.
>
>I have not been able to get my ps/2 mouse to function with any
>2.6.x or 2.4.x kernel (same ASUS MB).  The problem is already
>so long standing that I have completely given up on it and use
>a serial mouse exclusively and no longer bother with ps/2.
>
>(I also hate to report that since I dual boot with MS Windows,
>the ps/2 mouse functions properly under the same conditions
>with MS Windows 2K.  The hardware cannot be at fault.) 
>
>  
>
>>As a clarification, I have been having these keyboard problems 
>>intermittently, regardless of whether I'm using -mm or mainline kernel.  
>>I was NOT having this problem in 2.6.11  I wasn't having the psaux mouse 
>>problems in 2.6.11 either  .... I unplugged my psaux mouse from that 
>>machine before 2.6.12-mainline was released, so I don't know if those 
>>symptoms are still present.
>>    
>>
>
>Actually, my keyboard problems began with kernel-2.6.11, but were
>quickly resolved when I used the following parameter in my lilo.conf
>file:
>
>i8042.nomux
>
>When I use this parameter, or any other i8042 specific parameter,
>with kernel-2.6.12, there is no effect.  The keyboard still occasionally
>comes up dead.
>
>Thanks for the information on unplugging and re-plugging the keyboard.
>I'll give that a try soon.
>
>Frank Peters
>
>(Please CC to frank.peters@comcast.net as I am not a subscriber to this
>list.)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


-- 
Michael Krufky


