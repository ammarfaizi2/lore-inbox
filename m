Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTEIT3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTEIT3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:29:14 -0400
Received: from lakemtao03.cox.net ([68.1.17.242]:23995 "EHLO
	lakemtao03.cox.net") by vger.kernel.org with ESMTP id S263426AbTEIT3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:29:13 -0400
Message-ID: <3EBC0469.4080508@cox.net>
Date: Fri, 09 May 2003 14:41:29 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Pfiffer <andyp@osdl.org>
CC: walt <wa1ter@hotmail.com>, Torrey Hoffman <thoffman@arnor.net>,
       Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA busted in 2.5.69
References: <fa.j6n4o02.sl813a@ifi.uio.no> <fa.juutvqv.1inovpj@ifi.uio.no>	 <3EBBF00D.8040108@hotmail.com> <1052507530.15922.37.camel@andyp.pdx.osdl.net>
In-Reply-To: <1052507530.15922.37.camel@andyp.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer wrote:
> On Fri, 2003-05-09 at 11:14, walt wrote:
> 
>>Torrey Hoffman wrote:
>>
>>>On Fri, 2003-05-09 at 01:09, Giuliano Pochini wrote:
>>>
>>>
>>>>On 08-May-2003 Torrey Hoffman wrote:
>>>>
>>>>
>>>>>ALSA isn't working for me in 2.5.69.  It appears to be because
>>>>>/proc/asound/dev is missing the control devices.
>>>
>>>...
>>>
>>>>If you are not using devfs, you need to create the devices. There is a
>>>>script in the ALSA-driver package to do that. Otherwise I can't help
>>>>you because I never tried devfs and linux 2.5.x.
>>>
>>>No.  /dev/snd is a symbolic link to /proc/asound/dev,
>>>and that symbolic link was created by the script you mention.
>>>(I am not using devfs.)
> 
> 
> I'm not using devfs, and I've had no luck getting ALSA to work on my
> i810-audio system.  OSS works fine.
> 
> Is there a step-by-step writeup available for morons like me that
> haven't gotten ALSA working?

I have ALSA working under 2.4.21-rc1 using Erik's kernel patch, but I 
cannot get it to work under 2.5.69. I don't know what's wrong. I get 
Audio from my CD-ROM since it is connected to my sound card, but I get 
no sound from the Arts sound server in KDE. I get no errors and no warnings.
I don't understand how it can't work. I'm thinking that the OSS 
emulation is broken. The ALSA version I have for 2.4 is 0.9.2. 0.9.3a is 
in 2.5.69, right? Have any bugs been reported to the ALSA people?

Regards,
David

