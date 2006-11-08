Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754286AbWKHFQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286AbWKHFQR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbWKHFQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:16:17 -0500
Received: from bay0-omc3-s13.bay0.hotmail.com ([65.54.246.213]:1179 "EHLO
	bay0-omc3-s13.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1754286AbWKHFQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:16:16 -0500
Message-ID: <BAY20-F11ABC4481755DCE7E07715D8F10@phx.gbl>
X-Originating-IP: [212.199.170.75]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <d120d5000611071237j509d0cbfxe441b68066fb75f5@mail.gmail.com>
From: "Burman Yan" <yan_952@hotmail.com>
To: dmitry.torokhov@gmail.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, khali@linux-fr.org
Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt handling
Date: Wed, 08 Nov 2006 07:16:10 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Nov 2006 05:16:15.0856 (UTC) FILETIME=[03DF5700:01C702F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
>To: "Burman Yan" <yan_952@hotmail.com>
>CC: akpm@osdl.org, linux-kernel@vger.kernel.org, khali@linux-fr.org
>Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt 
>handling
>Date: Tue, 7 Nov 2006 15:37:51 -0500
>
>On 11/7/06, Burman Yan <yan_952@hotmail.com> wrote:
>>
>> >From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
>> >To: "Andrew Morton" <akpm@osdl.org>
>> >CC: "Burman Yan" <yan_952@hotmail.com>, linux-kernel@vger.kernel.org, 
>>"Jean
>> >Delvare" <khali@linux-fr.org>
>> >Subject: Re: [PATCH] HP Mobile data protection system driver with 
>>interrupt
>> >handling
>> >Date: Mon, 6 Nov 2006 17:18:53 -0500
>> >
>> >On 11/6/06, Andrew Morton <akpm@osdl.org> wrote:
>> >>On Fri, 03 Nov 2006 18:33:31 +0200
>> >>"Burman Yan" <yan_952@hotmail.com> wrote:
>> >> > +
>> >> > +static unsigned int mouse = 0;
>> >>
>> >>The `= 0' is unneeded.
>> >>
>> >> > +module_param(mouse, bool, S_IRUGO);
>> >> > +MODULE_PARM_DESC(mouse, "Enable the input class device on module
>> >>load");
>> >
>> >Does the parameter have to be called "mouse"? I'd rename it to "input"
>> >and drop the work "class" from parameter description.
>>
>>Dropping the "class" seems logical, but calling the parameter input
>>seems confusing to me - to a user that doesn't want to read too much
>>manual/code and just wants to play around with the device (I do that
>>sometimes)
>>mouse sounds more reasonable to me.
>>
>
>Except that the device is more similar to a joystick than a mouse...

Agreed - joystick it is.

>
>--
>Dmitry

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

