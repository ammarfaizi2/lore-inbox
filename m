Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVFQB0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVFQB0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVFQB0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:26:45 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:37566
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261867AbVFQB0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:26:42 -0400
Message-ID: <42B218C5.9020406@linuxwireless.org>
Date: Thu, 16 Jun 2005 19:26:45 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Lars Roland <lroland@gmail.com>
CC: Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
References: <4ad99e0505061605452e663a1e@mail.gmail.com>	 <42B1F5CB.9020308@g-house.de>	 <4ad99e0505061615143cc34192@mail.gmail.com>	 <42B21130.4000608@g-house.de> <4ad99e0505061617052f427ed6@mail.gmail.com>
In-Reply-To: <4ad99e0505061617052f427ed6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Roland wrote:

>On 6/17/05, Christian Kujau <evil@g-house.de> wrote:
>  
>
>>Lars Roland schrieb:
>>    
>>
>>>It does not seams to be limited to braodcom cards. 3com and Intel e100
>>>cards does the exact same stunt on kernels never than 2.6.8.1. Intel
>>>e1000 and realtek 8139 cards do however work.
>>>      
>>>
>>hm - tricky, i think. because no kernel oopses, nothing to look at in the
>>syslog (yes?),
>>    
>>
>
>Nothing anywhere, even tcpdump just seams to get cut off - I have not
>been debugging ethernet drivers for years, getting a little rusty at
>that, so nothing there yet.
>
>  
>
>>various nic drivers affected, others not...in cases like
>>these only Documentation/BUG-HUNTING comes to my mind: if 2.6.8.1 works,
>>and 2.6.12-rc6 does not, we'll need to find out the kernelversion which
>>introduced this behaviour.
>>    
>>
>
>That I can give you, kernel 2.6.8.1 works but 2.6.9 does not (at least
>not with tg3 and tulip cards).
>
>
>Regards.
>
>Lars Roland
>
>  
>
one question,

    Can I know what is the problem? I have 2 tg3 adapters, lots of 
e100's and some Cisco PIX and devices.

I can try to reproduce it and see if anyone has something to say about it.

Let me know,

.Alejandro
