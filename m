Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSE2BN7>; Tue, 28 May 2002 21:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSE2BN6>; Tue, 28 May 2002 21:13:58 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.133]:26040 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S313113AbSE2BN5>; Tue, 28 May 2002 21:13:57 -0400
Date: Tue, 28 May 2002 21:18:57 -0400
From: sean darcy <seandarcy@hotmail.com>
Subject: Re: Sony DSC-P71 Camera
To: Colin Slater <hoho@binbash.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Message-id: <3CF42C81.5030004@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
Newsgroups: fa.linux.kernel
In-Reply-To: <fa.f4d1oiv.3kegor@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You don't say which kernel you're using. I have a p71 which I can't get 
to work with 2.5.18 - see the mass storage thread. OTOH, a stock rh 
2.4.18 kernel works just fine.

What does usbview show? What are the usb and scsi snips from .config. 
What hapens when you try to mount sd*  ?


Colin Slater wrote:
> Hello, 
>  I just got a Sony DSC-P71 digital camera (wonderful), but it doesn't
> seem to be working in linux. I beleive it uses the usb mass storage
> driver, it seems to use an equivilent driver in windows. I have scsi,
> usb, usb mass storage modules all loaded. 
> dmesg after I load the usb-storage module, and then plug the camera in:
> 
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> hub.c: USB new device connect on bus1/1, assigned device number 3
> scsi0 : SCSI emulation for USB Mass Storage devices
> 
> I am useing devfs, and /dev/scsi is empty.
> 
> cat /proc/bus/usb/devices:
> <snip>
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=054c ProdID=0010 Rev= 4.10
> S:  Manufacturer=Sony
> S:  Product=Sony DSC
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=ff Prot=01 Driver=(none)
> E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
> <snip>
> 
> All this happens regardless of NVdriver being loaded or not.
> 
> If someone with one of these cameras or the nearly identical DSC-P31
> could help me, it would be appreciated
> 
> Colin
> 
> 



