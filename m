Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264687AbUD1IVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264687AbUD1IVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 04:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUD1IVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 04:21:21 -0400
Received: from zasran.com ([198.144.206.234]:63902 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S264687AbUD1IVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 04:21:18 -0400
Message-ID: <408F697D.2010906@bigfoot.com>
Date: Wed, 28 Apr 2004 01:21:17 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
References: <40853060.2060508@bigfoot.com> <408EF33F.5040104@bigfoot.com> <1083136394.23415.4.camel@amilo.bradney.info> <200404281022.23878.kim@holviala.com>
In-Reply-To: <200404281022.23878.kim@holviala.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Holviala wrote:
> On Wednesday 28 April 2004 10:13, Craig Bradney wrote:
> 
> 
>>>>>> the mouse says: Cordless MouseMan Wheel (Logitech), it has
>>>>>>left/right buttonss, wheel that can be pushed or rotated and a side
>>>>>>button, not sure how to better identify it. With 2.4 kernels it used
>>>>>>to work with X using protocol MouseManPlusPS/2.
>>>>>
>>>>>  anybody? any hints? should I look at driver? are there some docs for
>>>>>logitech mice (protocol)?
>>>>
>>>>err.. they all Just Work (tm) here.. ps2 or USB, IMPS/2 driver
>>>
>>>   which kernel (mine doesn't work with 2.6.5, used to work with 2.4.x),
>>>which mouse models? I guess there might be more models and for some
>>>reason my particular model does not work. Can you find out which
>>>protocol the kernel is using (psmouse, not usb)?
>>
>>2.4.x, 2.61,3,5, currently 2.6.5 on 4 PCs
>>
>>-logitech cordless optical for notebooks (USB)
>>-logitech cordless mouseman optical (via a kmv switch to 2PCs )(ps2)
>>-logitech cordless optical mouse(ps2)
>>
>>err. how do i find out the protocol the kernel uses?
> 
> 
> Check your kernel logs (/var/log/messages perhaps). Grepping for "psmouse" 
> will help you find the relevant part.

   didn't find anything for psmouse but found these in dmesg output 
after doing modprobe psmouse with difeferent protocols (you can see I 
was trying different protocols, none of them worked (turning wheel 
doesn't work, sidebutton is same as middle button):

input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
input: PS2++ Logitech Mouse on isa0060/serio1
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: PS2++ Logitech Mouse on isa0060/serio1
input: PS/2 Generic Mouse on isa0060/serio1
input: PS/2 Generic Mouse on isa0060/serio1
input: ExPS/2 Generic Explorer Mouse on isa0060/serio1

	erik
