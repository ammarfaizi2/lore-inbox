Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbULHSJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbULHSJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbULHSGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:06:24 -0500
Received: from smtp08.web.de ([217.72.192.226]:27835 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S261288AbULHSB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:01:56 -0500
Message-ID: <41B74174.3080908@web.de>
Date: Wed, 08 Dec 2004 18:01:24 +0000
From: Felix Dorner <felix_do@web.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-laptop@mobilix.org
Subject: internal card reader support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


My notebook (hp nx9105) has an integrated 5in1 card-reader. I would 
really like to use this with linux.
Since I do not think it is supported yet, I d like to know if it might 
be possible to write a module or so for this.
I am just an average C programmer, but always wanted to dive into kernel 
developement. My knowledge on computer architecture is also no more than 
basic, so this might be something to really learn a lot...
So I start at zero knowledge now. First of course I need to find out if  
what I want to do is possible at all.
This means now to identify the hardware inside and see if I can get 
documents for that.

First I just start with:

#lspci
[...]
0000:02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
0000:02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
0000:02:04.2 System peripheral: Texas Instruments: Unknown device 8201 
(rev 01)
[...]

This is all that I have. Now I am already confused. My box has one 
PCMCIA slot. Which is now the PCMCIA and which is the CardReader? What 
about the third device? Might this be the integrated infrared controller?

Can you give me any hints/tips where to start best, what to read first?

I know this seems to be very difficult, but I have quite some free time 
that I don't want to spend playing bzflag all night long, so I think 
this is a great way to learn something.

Thanks for your advice,
Felix

