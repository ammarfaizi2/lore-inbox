Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTDCI6r>; Thu, 3 Apr 2003 03:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263325AbTDCI6r>; Thu, 3 Apr 2003 03:58:47 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:3391 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S263321AbTDCI6q>; Thu, 3 Apr 2003 03:58:46 -0500
Date: Thu, 03 Apr 2003 01:10:59 -0800
From: Nehal <nehal@canada.com>
Subject: Re: mount hfs on SCSI cdrom = segfault
In-reply-to: <XFMail.20030403100629.pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Reply-to: linux-kernel@vger.kernel.org
Message-id: <3E8BFAA3.7010608@canada.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
References: <XFMail.20030403100629.pochini@shiny.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

>On 02-Apr-2003 Nehal wrote:
>  
>
>>ok you are right! i set hdc=scsi, reboot, and mounted my
>>ide cdrom drive (device /dev/scd1) as hfs, and boom
>>it crashed with same message :)  this is good, at least
>>i know its not my scsi drive/controller at fault
>>
>>so definitely a bug in scsi somehow or somewhere,
>>so i guess anyone with a hfs cd can reproduce, so
>>somebody please fix :)
>>    
>>
>
>Once upon a time it worked just fine. Then someone removed
>support for !=512 bytes sectors...
>To workaround, use loopback.
>
(yes Oliver has told me about this workaround)

1. do u know why it was removed?
2. is there a reason why can't support for it be put back?

thx, Nehal


