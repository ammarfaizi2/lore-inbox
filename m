Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVHYSuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVHYSuc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVHYSuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:50:32 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:30826 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932355AbVHYSub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:50:31 -0400
X-ME-UUID: 20050825185022770.BC0811C0021B@mwinf0307.wanadoo.fr
Message-ID: <430E1246.5020107@worldonline.fr>
Date: Thu, 25 Aug 2005 20:47:34 +0200
From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; fr-FR; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: fr-fr, en-us
MIME-Version: 1.0
To: Sebastian Kaergel <mailing@wodkahexe.de>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>	<20050825194954.6db42e90.mailing@wodkahexe.de>	<430DF08C.8010604@gmail.com> <20050825210148.4f60e531.mailing@wodkahexe.de>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       Sorry but could you re-explain me the problem. Tony, you've only 
CC'ed me the end of the story.

    Just a correction the options are video=intelfb:accel=0,hwcursor=0 
with = and not :

Regards
Sylvain

Sebastian Kaergel a écrit:

>On Fri, 26 Aug 2005 00:23:40 +0800
>"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
>  
>
>>Sebastian Kaergel wrote:
>>    
>>
>>>On Tue, 23 Aug 2005 22:08:13 -0700 (PDT)
>>>Linus Torvalds <torvalds@osdl.org> wrote:
>>>
>>>      
>>>
>>>>Sylvain Meyer:
>>>>  intelfb: Do not ioremap entire graphics aperture
>>>>        
>>>>
>>Probably this one. If vram is less than stolen size, intelfb
>>will only ioremap the framebuffer memory, excluding the
>>ringbuffer and the cursor memory.
>>
>>Try booting with video=intelfb:accel:0,nohwcursor:0.  If you get
>>a display, try this patch.
>>
>>CC'ed Sylvain.
>>
>>Signed-off-by: Antonino Daplas <adaplas@pol.net>
>>---
>>    
>>
><patch snipped>
>
>Hi,
>thanks for your quick reply, but it did not work. the screen remains
>black when booting with video=intelfb:accel:0,{,no}hwcursor:0
>
>  
>



