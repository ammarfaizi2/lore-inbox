Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSE1XVi>; Tue, 28 May 2002 19:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSE1XVh>; Tue, 28 May 2002 19:21:37 -0400
Received: from acd.ufrj.br ([146.164.3.7]:64528 "EHLO acd.ufrj.br")
	by vger.kernel.org with ESMTP id <S313125AbSE1XVg>;
	Tue, 28 May 2002 19:21:36 -0400
Message-Id: <200205282321.g4SNLVY98610@acd.ufrj.br>
Content-Type: text/plain; charset=US-ASCII
From: Scorpion <scorpionlab@ieg.com.br>
Reply-To: scorpionlab@ieg.com.br
Organization: ScorpionLAB
To: Nathan <wfilardo@fuse.net>, Colin Slater <hoho@binbash.net>
Subject: Re: Sony DSC-P71 Camera
Date: Tue, 28 May 2002 20:13:32 -0300
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022619053.894.35.camel@neptune> <3CF3F776.1040203@fuse.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Colin,
peopla at www.gphoto.net made some tests with these cameras model (DSC),
almost experimental, P5 model and others, maybe you could provide usefull 
informations for the gphoto team and help to get more one camera working on
Linux (and other OSes).

Bye;)
Scorpion.

On Tuesday 28 May 2002 18:32, The Kernel Developer Nathan wrote:
> Colin Slater wrote:
> >Hello,
> > I just got a Sony DSC-P71 digital camera (wonderful), but it doesn't
> >seem to be working in linux. I beleive it uses the usb mass storage
> >driver, it seems to use an equivilent driver in windows. I have scsi,
> >usb, usb mass storage modules all loaded.
> >dmesg after I load the usb-storage module, and then plug the camera in:
> >
> >Initializing USB Mass Storage driver...
> >usb.c: registered new driver usb-storage
> >USB Mass Storage support registered.
> >hub.c: USB new device connect on bus1/1, assigned device number 3
> >scsi0 : SCSI emulation for USB Mass Storage devices
> >
> >I am useing devfs, and /dev/scsi is empty.
> >
> >cat /proc/bus/usb/devices:
> ><snip>
> >T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> >D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> >P:  Vendor=054c ProdID=0010 Rev= 4.10
> >S:  Manufacturer=Sony
> >S:  Product=Sony DSC
> >C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
> >I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=ff Prot=01 Driver=(none)
> >E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> >E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> >E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
> ><snip>
> >
> >All this happens regardless of NVdriver being loaded or not.
> >
> >If someone with one of these cameras or the nearly identical DSC-P31
> >could help me, it would be appreciated
> >
> >Colin
>
> This camera doesn't use the mass storage driver (you don't show any log
> lines that indicate the driver claiming the device).  Instead I'd try
> the drivers under "USB Multimedia Devices" (you need v4l support).  A
> quick look doesn't look hopeful, but maybe one of those drivers will
> claim the device.  Anybody on LKML know for sure?
>
> --Nathan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
