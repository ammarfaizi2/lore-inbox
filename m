Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTHSXdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbTHSXdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:33:36 -0400
Received: from bay1-f29.bay1.hotmail.com ([65.54.245.29]:23312 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261492AbTHSXdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:33:33 -0400
X-Originating-IP: [12.25.43.10]
X-Originating-Email: [ckbroadbus@hotmail.com]
From: "ckbb ckbb" <ckbroadbus@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: USB device not accepting new address=2 (error=-19) 
Date: Tue, 19 Aug 2003 19:33:32 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F29tnhvCRohyMM0002e7a1@hotmail.com>
X-OriginalArrivalTime: 19 Aug 2003 23:33:32.0832 (UTC) FILETIME=[4D90E200:01C366AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am stuck with the following error. I really appreciate any help for this 
problem. May be it is known bug in the usb stack.

I am using linux2.4.21, powerpc processor, phillips 1161a host controller

I am getting interrupts & hardware seems to be OK. I have configured EHCI & 
OHCI, scsi, usb mass storage in the kernel configuration.


usb.c: new USB bus registered, assigned bus number 1
Product: USB OHCI Root Hub
SerialNumber: c7911000
hub.c: USB hub found
hub.c: 1 port detected
hcd_1161.c : usb devices found..
usbutil: USB int. status bits cleared 0x00060000
usbutil: USB interrupt.1 Enabled ox00020000
ISP116x_HCD Initialization Successful

usb.c: USB device not accepting new address=2 (error=-19)

usb.c: USB device not accepting new address=3 (error=-19)


root@10.0.0.160:/proc/bus/usb# cat drivers
usbdevfs
hub
usb-storage
root@10.0.0.160 :/proc/bus/usb# cat devices
T: Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#= 1 Spd=12 MxCh= 1
B: Alloc= 0/900 us ( 0%), #Int= 0, #Iso= 0
D: Ver= 1.10 Cls=09(hub ) Sub=00 Prot=00 MxPS= 8 #Cfgs= 1
P: Vendor=0000 ProdID=0000 Rev= 0.00
S: Product=USB OHCI Root Hub
S: SerialNumber=c7962400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr= 0mA
I: If#= 0 Alt= 0 #EPs= 1 Cls=09(hub ) Sub=00 Prot=00 Driver=hub
E: Ad=81(I) Atr=03(Int.) MxPS= 2 Ivl=255ms
root@10.0.0.160 :/proc/bus/usb#


cat of 'proc/scsi/scsi' is empty....

Thanks
Chandrasekhar Konakalla

_________________________________________________________________
<b>Get MSN 8</b> and help protect your children with advanced parental 
controls.  http://join.msn.com/?page=features/parental

