Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWGCUxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWGCUxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWGCUxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:53:45 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:42485 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932107AbWGCUxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:53:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q6wIBVKJ02btEl8/KDM2BtGrjJqouimYHYbNxDXWdT/FW2zU7Whj2HtQd7a65ZDRHoyl8fYwtNFJE7Rmaws/4LnmTRsUdR3PODekycj9Wa07mY/WgbnnflAXuC4pPzYPBTKThYMyzwOSuDXs2kmT5KQEpW1JFBMqYLhA1Ygjfc8=
Message-ID: <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>
Date: Mon, 3 Jul 2006 16:53:43 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Alon Bar-Lev" <alon.barlev@gmail.com>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <44A95F12.8080208@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>
	 <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>
	 <44A95F12.8080208@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hahahaha I wish I could... well, you are _always_ welcome to donate me
yours ! =P
I'll try more later to get one of those readers...

Reading Greg's comment, now I'm in doubt if this should really be in
kernel mode or at userspace. Since there is no standard (AFAIK) for
those readers, how should it be done ?

Another thing: where can I find documentation about the USB
architecture ? For example, I suppose that some (or all) USB devices
may have DMA capabilities... how is this done ?

[]'s
Daniel



On 7/3/06, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> Daniel Bonekeeper wrote:
> > Hello Alon !
> > Unfortunately I don't have an accessible thinkpad laptop (luckly the
> > external usb devices may work the same way). From the USB readers at
> > http://www.upek.com/products/usb.asp, which one do you think that fits
> > better the hardware on your laptop ?
>
> I think that the TCRE3C is similar to the laptop one. I also
> hope that it is the same... Also the laptop integrated one
> is USB device.
>
> Here is my device information:
>
> Bus 003 Device 011: ID 0483:2016 SGS Thomson Microelectronics
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               1.00
>    bDeviceClass            0 (Defined at Interface level)
>    bDeviceSubClass         0
>    bDeviceProtocol         0
>    bMaxPacketSize0         8
>    idVendor           0x0483 SGS Thomson Microelectronics
>    idProduct          0x2016
>    bcdDevice            0.01
>    iManufacturer           1 STMicroelectronics
>    iProduct                2 Biometric Coprocessor
>    iSerial                 0
>    bNumConfigurations      1
>    Configuration Descriptor:
>      bLength                 9
>      bDescriptorType         2
>      wTotalLength           39
>      bNumInterfaces          1
>      bConfigurationValue     1
>      iConfiguration          0
>      bmAttributes         0xa0
>        Remote Wakeup
>      MaxPower              100mA
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        0
>        bAlternateSetting       0
>        bNumEndpoints           3
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass      0
>        bInterfaceProtocol      0
>        iInterface              0
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x81  EP 1 IN
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0040  1x 64 bytes
>          bInterval               0
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x02  EP 2 OUT
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0040  1x 64 bytes
>          bInterval               0
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x83  EP 3 IN
>          bmAttributes            3
>            Transfer Type            Interrupt
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0004  1x 4 bytes
>          bInterval              20
>
>
> > I was looking for any place that sells those devices and I could not
> > find any online (even though I found lots of SDK and matching engines
> > that supports them, like VeriFinger).
> >
> > Is there any place where I can buy one of those readers ?
>
> Oh... I really don't know...
> You can buy a new laptop :)
>
> Best Regards,
> Alon Bar-Lev.
>
>


-- 
What this world needs is a good five-dollar plasma weapon.
