Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSIYNqX>; Wed, 25 Sep 2002 09:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261981AbSIYNqX>; Wed, 25 Sep 2002 09:46:23 -0400
Received: from [202.64.97.34] ([202.64.97.34]:54539 "EHLO main.coppice.org")
	by vger.kernel.org with ESMTP id <S261978AbSIYNqW>;
	Wed, 25 Sep 2002 09:46:22 -0400
Message-ID: <3D91BF58.8080803@coppice.org>
Date: Wed, 25 Sep 2002 21:51:20 +0800
From: Steve Underwood <steveu@coppice.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020911
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB IEEE1284 gadgets and ppdev
References: <3D90831A.7060709@coppice.org> <20020924162130.GE9457@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:

>On Tue, Sep 24, 2002 at 11:22:02PM +0800, Steve Underwood wrote:
>
>  
>
>>Can the USB driver for USB to IEEE1284 gadgets be used with the ppdev 
>>interface? I looked through the documentation and couldn't find a 
>>mention of this one way or the other. The structures used by parport and 
>>the USB stuff look similar, but I couldn't see how to get ppdev to play 
>>with the USB driver.
>>    
>>
>
>Which driver are you using?  It ought to be hooked into the parport
>stuff (parport_register_driver etc) like USS720, and then it'll work.
>
>Tim.
>*/
>  
>
Thanks for responding.

As far as I can tell there are only two USB drivers for USB-to-IEEE1284 
devices - USS720 for the USS720 device, and usblp for everything else. 
Is usblp supposed to hook into ppdev? Is there some other device driver 
I missed?

Regards,
Steve



