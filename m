Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbTDONcr (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbTDONcr 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:32:47 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:39836 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S261482AbTDONcn 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 09:32:43 -0400
From: Balram Adlakha <b_adlakha@softhome.net>
To: john@grabjohn.com
Subject: Re: module for sony network walkman
Date: Tue, 15 Apr 2003 19:18:19 +0000
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304151918.19936.b_adlakha@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Is there any driver available for accessing the flash memory of my sony usb
> >network walkman (nw-e5)? This thing was quite expensive and I really would
> >like it to work. 

>At a guess, it might just act like a disk device. Without a lot more
>information, I can't help you any further. What does lsusb say about
>it?
>
>John. 

this is what lsusb says:


Bus 001 Device 002: ID 054c:0035 Sony Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x054c Sony Corp.
  idProduct          0x0035
  bcdDevice            1.00
  iManufacturer           1 Sony
  iProduct                2 Network-Walkman
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
  Language IDs: (length=4)
     0409 English(US)


however, I am not able to just load the usb-storage, scsi disk and scsi 
generic modules and mount it coz its not shown anywhere in /dev (devfs)
Will it work if I try some of the flash memory writer modules? What can I try? 
