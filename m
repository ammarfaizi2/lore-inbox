Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264404AbUEDOpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUEDOpw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 10:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264407AbUEDOpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 10:45:51 -0400
Received: from [195.23.16.24] ([195.23.16.24]:17811 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264405AbUEDOpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 10:45:41 -0400
Message-ID: <4097ABD7.1020505@grupopie.com>
Date: Tue, 04 May 2004 15:42:31 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Edward Macfarlane Smith <snowfire@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       tj <999alfred@comcast.net>
Subject: Re: mmc/sd drivers
References: <408D3DC0.8080700@comcast.net> <20040427141453.GQ2595@openzaurus.ucw.cz> <200405021749.46941.snowfire@blueyonder.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.3; VDF: 6.25.0.47; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Macfarlane Smith wrote:

> On Tuesday 27 April 2004 15:14, Pavel Machek wrote:
> 
>>Hi!
>>
>>
>>>Where can the latest mmc drivers in the kernel source be located? I
>>>am not talking about mass-storage usb or pcmcia drivers. I downloaded
>>>2.2.26 and there is no drivers/mmc directory. Where can the mmc
>>>drivers be located from their original distribution point?
>>>
>>2.2 is old.
>>
>>MMC is supported for example on sharp zaurus, look
>>there for sources. SD requires binary-only module. Avoid it.
>>
> 
> Thats not completely true. Last weekend I was using a 512Mb SD card on my iPAQ 
> 5550 with the 2.4.19 hh36.9 kernel from Handhelds.org. It was rather slow 
> access (playing mp3s directly off the sd card had problems with pauses), but 
> did work. I haven't actually got around to building a kernel for an ARM 
> machine yet, but if you need the source I suggest you look round 
> handhelds.org.

AFAIK, only the MMC-like modes of the SD cards are supported. The driver can't 
handle encryption, paralel data transfer modes (using 4 bits at a time) or SDIO 
cards.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

