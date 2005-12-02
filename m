Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbVLBLTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbVLBLTK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbVLBLTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:19:10 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:15786 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932730AbVLBLTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:19:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=L9jNdl/wJ5FHEkxrqe9ygA13z2/KXTiD7IpYm1azACiZiBNf0aPWjyzjZcgkt7BcOCAMfC3Q4BU3oR3hln4YqmnS2H48YjCvU+gb17X45Wb8CAtmDEc55AgxOcYwVJum8FDoUzAkL7fEpgxNZvy6X4YrKUJ4V3NIgVGnqnz0K5o=
Message-ID: <43902DA5.9030708@gmail.com>
Date: Fri, 02 Dec 2005 12:19:01 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       pavel@ucw.cz, shaohua.li@intel.com, akpm@osdl.org
Subject: Re: 2.6.15-rc2-git5 continues to fail suspending (USB issue)
References: <Pine.LNX.4.44L0.0511261552290.15477-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0511261552290.15477-100000@netrider.rowland.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern ha scritto:

>On Sat, 26 Nov 2005, Patrizio Bassi wrote:
>
>  
>
>>>Maybe it's a problem in the device.
>>>
>>> 
>>>
>>>      
>>>
>>no..why should after resume?
>>    
>>
>
>How should I know?  It's _your_ device.  :-)
>
>  
>
>>however i remember some kernels ago (.13/.14) it worked
>>after resume hotplug restarted my driver, now not.
>>    
>>
>
>To get some more useful information in the system log, turn on USB
>debugging (CONFIG_USB_DEBUG) and enable usbcore's usbfs_snoop=Y module
>parameter.
>
>Alan Stern
>
>
>  
>
Alan, i just upgrated to 2.6.15-rc3 and it works after suspend.
hotplug starts driver lovely.

so it was a kernel bug, as i suspected.

now only userspace driver shutdown needed.
waiting next kernel versions :)
