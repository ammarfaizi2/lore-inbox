Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271529AbRHUE0t>; Tue, 21 Aug 2001 00:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271530AbRHUE0j>; Tue, 21 Aug 2001 00:26:39 -0400
Received: from web14601.mail.yahoo.com ([216.136.224.79]:52743 "HELO
	web14601.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271529AbRHUE0V>; Tue, 21 Aug 2001 00:26:21 -0400
Message-ID: <20010821042636.69274.qmail@web14601.mail.yahoo.com>
Date: Mon, 20 Aug 2001 21:26:36 -0700 (PDT)
From: cardhore <cardhore@yahoo.com>
Subject: Microtech ZiO! CompactFlash USB (usb mass storage)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> *please CC all replies to cardhore@yahoo.com as well
> as the list.  (I am not subscribed.)  Thank you.
> 
> I have a MicroTech brand ZiO! CompactFlash Card
> Reader/Writer, I'm attempting to use it with linux
> 2.4.9, and I'd appreciate any help with it.  I have
> tried using the following drivers:
> *hp8200e
> *sddr09
> *dpcm
> *shuttle_cf (there is no code for this. (?) )
> but they do not bind to the device.  I also tried
> adding its product ID to unusual_devs.h but that did
> not seem to work (I do not know how to do it
> properly).
> 
> When I plug in the device (with the module
> installed),
> I get
> hub.c: USB new device connect on bus1/1/4, assigned
> device number 13
> usb.c: USB device 13 (vend/prod 0x4e6/0x1010) is not
> claimed by any active driver.
> 
> Here is the entry for this from usb/devices:
> 
> T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#= 12
> Spd=12  MxCh= 0
> D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=16
> #Cfgs=  1
> P:  Vendor=04e6 ProdID=1010 Rev= 0.05
> S:  Manufacturer=SHUTTLE
> S:  Product=SCM Micro USBAT-02 
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01
> Prot=ff
> Driver=(none)
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=  5ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=  0mss
> I am sure that this USB setup functions, because I
> am
> using keyboards, mice, and camera which all work
> great!
> 
> Thank you.


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
