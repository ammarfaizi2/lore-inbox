Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBHUal>; Thu, 8 Feb 2001 15:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBHUac>; Thu, 8 Feb 2001 15:30:32 -0500
Received: from mail4.mia.bellsouth.net ([205.152.144.16]:23684 "EHLO
	mail4.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129026AbRBHUaR>; Thu, 8 Feb 2001 15:30:17 -0500
Message-ID: <3A830184.2090107@bellsouth.net>
Date: Thu, 08 Feb 2001 15:28:52 -0500
From: Louis Garcia <louisg00@bellsouth.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-5 i686; en-US; 0.7) Gecko/20010202
X-Accept-Language: en
MIME-Version: 1.0
To: Bakonyi Ferenc <fero@drama.obuda.kando.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: nvidia fb 0.9.0 (0.9.2?)
In-Reply-To: <3A7EF830.50805@bellsouth.net> <E14Qpuo-0004aR-00@aleph0.datakart.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bakonyi Ferenc wrote:

> /me wrote:
> 
>> Louis Garcia <louisg00@bellsouth.net> wrote:
>> 
>>> I'm using XFree86-4.0.1 with the nv driver. You are right, it's ver 
>>> 0.9.2 for the fb.
>>> 
>>> Where can I get the patch? Should I upgrade to XFree86-4.0.2?
>> 
>> Not yet, we have to write that patch first... :) I'll grab an XFree 
>> source soon.
>> Please test other color depths too: 15bpp and 32bpp.
> 
> 
> 	Hi!
> 
> I've tried to reproduce your problem, but I failed. Rivafb 0.9.2 on 
> Asus V3000 (Riva 128) with nv driver (from XFree-4.0.1g, Debian 
> Woody) works fine for me. Would you like to try out some other XFree 
> versions too?
> 
> Regards:
> 	Ferenc Bakonyi
> 
> 
> 
> 
On a nvidia riva 128 and a stock rh7 with kernel-2.4.1ac4 and above 
which has rivafb-0.9.2 when I startx the desktop is dark. This is in 
16bit and 24bit modes.
I have been told the Riva hardware can be programmed to expect 8 bit or 
6 bit color registers. Rivafb < 0.7.2 used 6 bit color registers, but 
the hw was programmed to 8 bit registers on TNT/TNT2. That was causing 
the so called 'dark console' bug. Rivafb 0.9.2 begins to utilize 8 bits 
on Riva 128, but the XFree86-4.0.1 server uses only 6 bits of them so 
your desktop's brightness is 1/4.

Louis Garcia

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
