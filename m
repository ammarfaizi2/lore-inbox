Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTICUBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTICT7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:59:22 -0400
Received: from smtp.terra.es ([213.4.129.129]:61782 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id S264436AbTICT66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:58:58 -0400
Message-ID: <3F56478F.9030002@terra.es>
Date: Wed, 03 Sep 2003 21:57:03 +0200
From: tonildg <tonildg@terra.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030830 Debian/1.4-3.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
CC: Sebastian Reichelt <SebastianR@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.21] orinoco_cs card reinsertion
References: <Pine.LNX.4.44.0309031643400.6102-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0309031643400.6102-100000@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure, but can this be related with the stuff commented before in 
this list with the subjects "Airo Net 340 PCMCIA WiFi Card trouble" ?


Marcelo Tosatti wrote:
> 
> On Wed, 3 Sep 2003, Sebastian Reichelt wrote:
> 
> 
>>>Can you please try 2.4.22? It contains orinoco changes including in
>>>the area you changed. 
>>
>>Sorry, 2.4.22 (from kernel.org) just hangs when I insert the card, after
>>the first of two beeps. Ctrl-Alt-Del doesn't work. No messages are
>>printed except the usual "cs: memory probe 0xa0000000-0xa0ffffff:
>>clean.", and syslog doesn't seem to have been flushed (it's cut off at
>>a higher position).
>>
>>One thing I noticed from syslog is that the socket is assigned another
>>IRQ: 5 instead of 9.
> 
> 
> Hum, are you using ACPI? There have a few IRQ assignment issues reported 
> with the new ACPI in 2.4.22.
> 
> Can you please try booting with "pci=noacpi" option ? 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


