Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVBBKUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVBBKUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 05:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVBBKUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 05:20:55 -0500
Received: from smtp05.web.de ([217.72.192.209]:23788 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S262230AbVBBKUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 05:20:46 -0500
Message-ID: <4200A9F3.80908@web.de>
Date: Wed, 02 Feb 2005 11:22:43 +0100
From: Victor Hahn <victorhahn@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Really annoying bug in the mouse driver
References: <41E91795.9060609@web.de> <200502011819.12304.dtor_core@ameritech.net> <42006E79.7070503@web.de> <200502020126.37621.dtor_core@ameritech.net>
In-Reply-To: <200502020126.37621.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>It still complains in dmesg about throwing away bytes, right? Please try
>loading the box some more to make sure mouse survives some abuse.
>  
>

No, it doesn't. The only message I still get is the one below. I've 
tried it with aprox. 90% CPU usage already and I didn't have any 
additional problems.

>>kernel: psmouse.c: bad data from KBC - bad parity
>>    
>>
>Your keyboard controller reported that the byte transmitted from the mouse
>was mangled somehow and we should not trust it. I am not sure why it would
>make mouse jump.. was there any mention of "reconnect" in the logs? Did it
>happen just once?
>

It happened once when I was at the computer and several times while I 
wasn't. There's no "reconnect" in the logs:

victor@vic:~$ cat /var/log/messages | grep reconnect
victor@vic:~$ 

Regards,
Victor
