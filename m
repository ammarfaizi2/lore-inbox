Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbTJGWZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 18:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTJGWZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 18:25:22 -0400
Received: from [200.214.116.9] ([200.214.116.9]:16573 "HELO vialink.com.br")
	by vger.kernel.org with SMTP id S262910AbTJGWZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 18:25:18 -0400
Message-ID: <3F833DAF.1080308@vialink.com.br>
Date: Tue, 07 Oct 2003 19:26:55 -0300
From: Juan Carlos Castro y Castro <jcastro@vialink.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel doesn't see USB ADSL modem - pegasus?
References: <3F7F7A9E.1060204@vialink.com.br> <20031007180851.GH1956@kroah.com>
In-Reply-To: <20031007180851.GH1956@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*sigh* I can use it with ethernet instead of USB. I don't mind 
installing a new piece of hardware in order to run Linux, but I'd like 
it to be "fully" compatible for the masses. Who in the kernel team would 
likely be able to come up with an USB driver if sent one of those 
devices? You? You? You over there? The fellow in the back row with the 
nose piercing? ;)

Greg KH wrote:

>On Sat, Oct 04, 2003 at 10:57:50PM -0300, Juan Carlos Castro y Castro wrote:
>  
>
>>Well, it didn't work -- I inserted the following line in pegasus.h:
>>
>>PEGASUS_DEV( "SpeedStream", VENDOR_SIEMENS, 0xe240,
>>DEFAULT_GPIO_RESET | PEGASUS_II )
>>
>>Because that's what appeared in /proc/bus/usb/devices. But now, modprobe 
>>pegasus hangs (the process, not the machine). Also, any attemp to access 
>>/proc/bus/usb hangs the process. Kudzu hangs too. Now I reached the 
>>limits of my knowledge. :(
>>    
>>
>
>Sorry, this device is probably not supported by that driver :(
>
>Can you return it and get something else?
>
>Good luck,
>
>greg k-h
>
>
>  
>


