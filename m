Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293426AbSCOWXj>; Fri, 15 Mar 2002 17:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293423AbSCOWXT>; Fri, 15 Mar 2002 17:23:19 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:10676 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S293410AbSCOWXH>; Fri, 15 Mar 2002 17:23:07 -0500
Message-Id: <200203152223.g2FMNDf21690@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Greg KH <greg@kroah.com>
Subject: Re: USB-Storage in 2.4.19-pre
Date: Sat, 16 Mar 2002 00:23:01 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203141432.g2EEWL628078@lmail.actcom.co.il> <200203150050.g2F0oR615927@lmail.actcom.co.il> <20020315182603.GC4310@kroah.com>
In-Reply-To: <20020315182603.GC4310@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 March 2002 20:26 pm, Greg KH wrote:
> On Fri, Mar 15, 2002 at 02:50:15AM +0200, Itai Nahshon wrote:
> > Again, I do not see the disk usind usbview (or in /proc/bus/usb/devices)
> > so I believe the problem is more with detection than with initialization.
>
> Sounds like it's a flaky USB device :)
>
> Does this device work on any other machines?

I use it on my computers at home and in the office. Very handy
when I want to share large data. It also worked on Windows 98
(with their supplied diricer on diskette from DataStor) until I
reformatted the disk as EXT3.

This is what I now have on USB (/proc/bus/usb/devices - Using 2.4.19-pre1).
If you believe it might help, I can also open the box and tell you exactly
what's on the adapter card (IIRC it's a Cypress processor but I'm not sure).

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=04e6 ProdID=0001 Rev= 2.00
S:  Manufacturer=Anchor Chips, Inc.
S:  Product=Firmware FrameWorks
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usb-storage
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=118/900 us (13%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c001 Rev= 1.20
S:  Manufacturer=Logitech
S:  Product=USB-PS/2 Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl= 10ms

>
> thanks,
>
> greg k-h
