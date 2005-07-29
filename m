Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVG2Fos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVG2Fos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 01:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVG2Fos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 01:44:48 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:36527 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262374AbVG2For (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 01:44:47 -0400
Message-ID: <42E9C245.6050205@m1k.net>
Date: Fri, 29 Jul 2005 01:44:37 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: frank.peters@comcast.net, vojtech@suse.cz,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
References: <20050624113404.198d254c.frank.peters@comcast.net>	<42BC306A.1030904@m1k.net>	<20050624125957.238204a4.frank.peters@comcast.net>	<42BC3EFE.5090302@m1k.net> <20050728222838.64517cc9.akpm@osdl.org>
In-Reply-To: <20050728222838.64517cc9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michael Krufky <mkrufky@m1k.net> wrote:
>  
>
>>I am cc'ing your message to Vojtech Pavlik, the INPUT DRIVERS kernel 
>>maintainer.
>>
>>Vojtech, I figured these should be sent to you.  If I am wrong, please 
>>redirect them to the correct person / list and let us know.
>>
>>Thank you.
>>
>>Frank Peters wrote:
>>
>>    
>>
>>>On Fri, 24 Jun 2005 12:10:18 -0400
>>>Michael Krufky <mkrufky@m1k.net> wrote:
>>>
>>> 
>>>
>>>      
>>>
>>>>I am having the same problem with my Shuttle FT61 motherboard, although 
>>>>I have not tried to disable ACPI... Until now I thought I just had a 
>>>>faulty keyboard, as my method to fix this was to unplug the keyboard and 
>>>>plug it back in after bootup.  When this happens, I see this in dmesg as 
>>>>the last line:
>>>>
>>>>input: AT Translated Set 2 keyboard on isa0060/serio0
>>>>
>>>>I am also having problems with my AUX mouse, as seen in message
>>>>
>>>>Subject: 2.6.12-rc5-mm1 breaks serio: i8042 AUX port
>>>>
>>>>Frank, are you having problems with your ps/2 mouse port as well?
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>I am so glad that you asked this.
>>>
>>>I have not been able to get my ps/2 mouse to function with any
>>>2.6.x or 2.4.x kernel (same ASUS MB).  The problem is already
>>>so long standing that I have completely given up on it and use
>>>a serial mouse exclusively and no longer bother with ps/2.
>>>
>>>(I also hate to report that since I dual boot with MS Windows,
>>>the ps/2 mouse functions properly under the same conditions
>>>with MS Windows 2K.  The hardware cannot be at fault.) 
>>>
>>> 
>>>
>>>      
>>>
>>>>As a clarification, I have been having these keyboard problems 
>>>>intermittently, regardless of whether I'm using -mm or mainline kernel.  
>>>>I was NOT having this problem in 2.6.11  I wasn't having the psaux mouse 
>>>>problems in 2.6.11 either  .... I unplugged my psaux mouse from that 
>>>>machine before 2.6.12-mainline was released, so I don't know if those 
>>>>symptoms are still present.
>>>>   
>>>>
>>>>        
>>>>
>>>Actually, my keyboard problems began with kernel-2.6.11, but were
>>>quickly resolved when I used the following parameter in my lilo.conf
>>>file:
>>>
>>>i8042.nomux
>>>
>>>When I use this parameter, or any other i8042 specific parameter,
>>>with kernel-2.6.12, there is no effect.  The keyboard still occasionally
>>>comes up dead.
>>>
>>>Thanks for the information on unplugging and re-plugging the keyboard.
>>>I'll give that a try soon.
>>>
>>>      
>>>
>
>Guys, are these problems fixed in 2.6.13-rc4?
>
>If not, please cc linux-kernel on the reply, thanks.
>  
>

Sadly, I must report that yes, the problem still intermittently occurs 
in 2.6.13-rc4 :-(  I'm the one that tested on the Shuttle FT61 
Motherboard.  Never has a problem in windows and never in 2.6.11 and 
earlier.

I first noticed this problem sometime during 2.6.12-rc series.

-- 
Michael Krufky

