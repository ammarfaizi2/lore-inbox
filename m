Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbTJ0JNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTJ0JNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:13:42 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:59265 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261429AbTJ0JNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:13:40 -0500
Message-ID: <3F9CE19F.90104@cyberone.com.au>
Date: Mon, 27 Oct 2003 20:13:03 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [long] linux-2.6.0-test9, XFree86 4.2.1.1, ATI ATI Radeon VE
 QY, screen hangs on 3d apps
References: <3F9B8A6B.6030102@hundstad.net> <3F9B9BEB.5060908@cyberone.com.au> <3F9B9032.8090804@hundstad.net> <3F9BA173.60705@cyberone.com.au> <3F9CC622.3000809@hundstad.net>
In-Reply-To: <3F9CC622.3000809@hundstad.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeffrey E. Hundstad wrote:

>
>
> Nick Piggin wrote:
>
>>
>>> The priority was set at -10.
>>>
>>> After setting the priority to 0 as you suggest nothing changes.
>>>
>>> $glxgears
>>>
>>> frame appears,
>>> screen hangs.
>>> I can move the cursor around, but this gets boring fast ;-)
>>>
>>
>> Oh sorry, you said you can't get the screen back without a reboot.
>> Can you ssh into the hung box?
>>
> Yes, I can.  Do you have any suggestions to what I can look for?
>

No I'm not sure. I guess its an X or 3d driver problem. Any messages
from dmesg or X's error log. Any processes stuck in D state or using
100% cpu. You should report the problem to ATI if you are using
closed source drivers.



