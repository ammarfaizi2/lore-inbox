Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280857AbRKOOYy>; Thu, 15 Nov 2001 09:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280848AbRKOOYo>; Thu, 15 Nov 2001 09:24:44 -0500
Received: from [216.80.8.1] ([216.80.8.1]:33297 "HELO mercury.prairiegroup.com")
	by vger.kernel.org with SMTP id <S280845AbRKOOYa>;
	Thu, 15 Nov 2001 09:24:30 -0500
Message-ID: <3BF3D029.7070609@prairiegroup.com>
Date: Thu, 15 Nov 2001 08:24:41 -0600
From: Martin McWhorter <m_mcwhorter@prairiegroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
In-Reply-To: <3BF2DFBF.6090502@prairiegroup.com> <20011114145312.A6925@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg

Do you have the same problem without the preemptive patch?


Yes. I appoligize for not being clear. I get the same results with plain 
2.4.14 w/out the preemptive patch.


If so, can you send the results of /proc/bus/usb/devices andT:  Bus=01 
Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2


B:  Alloc=159/900 us (18%), #Int=  4, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 3
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03f0 ProdID=010c Rev= 0.01
S:  Manufacturer=HP
S:  Product=Multimedia Keyboard Hub
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03f0 ProdID=020c Rev= 0.01
S:  Manufacturer=HP
S:  Product=Multimedia Keyboard Hub
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl= 10ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
E:  Ad=82(I) Atr=03(Int.) MxPS=   4 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  4 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c001 Rev=11.01
S:  Manufacturer=Logitech
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 26mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl= 10ms


 > /proc/bus/usb/drivers?

          usbdevfs
          hub
          hid
          keyboard

Thanks,
Martin

