Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbUJXJ6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUJXJ6f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUJXJ6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:58:35 -0400
Received: from main.gmane.org ([80.91.229.2]:13483 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261415AbUJXJ6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:58:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: Re: Weird behaviour of usb printer (drivers/usb/class/usblp.c:  
 usblp0: error -110 reading printer status)
Date: Sun, 24 Oct 2004 11:58:10 +0200
Message-ID: <417B7CB2.4050805@gmx.net>
References: <mailman.1098049140.31627.linux-kernel2news@redhat.com> <20041020190207.27b93ba0@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-153-47-58.dyn.salzburg-online.at
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20040916
X-Accept-Language: en-us, en
In-Reply-To: <20041020190207.27b93ba0@lembas.zaitcev.lan>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You are making a usual mistake here. It is essential for you not to
> cover the widest possible field at this point, but to name AT LEAST ONE
> version which is proven to have this defect.

Okay, i am sure that 2.6.9-rc3 has this mistake

> 
> Also, please send your /proc/bus/usb/devices.

Here the output. The printer is accepted and works at this moment. 
Current kernel is 2.6.9, don't know if the failure still exists though i 
  am using it just for about 2 hours yet and until the mistake almost 1 
day has gone. I will tell immediatly if the error doesn't come up again. 
If someone needs some more information just tell me.

Thanks for response

Georg Schild

> T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.9-gentoo-r1 uhci_hcd
> S:  Product=VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
> S:  SerialNumber=0000:00:10.2
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
> T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.9-gentoo-r1 uhci_hcd
> S:  Product=VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
> S:  SerialNumber=0000:00:10.1
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=03f0 ProdID=3304 Rev= 1.00
> S:  Manufacturer=Hewlett-Packard
> S:  Product=DeskJet 990C
> S:  SerialNumber=ES12C1D0Y5LG
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=07(print) Sub=01 Prot=02 Driver=usblp
> E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> 
> T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=129/900 us (14%), #Int=  2, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.9-gentoo-r1 uhci_hcd
> S:  Product=VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
> S:  SerialNumber=0000:00:10.0
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=046d ProdID=c404 Rev= 2.20
> S:  Manufacturer=Logitech
> S:  Product=Trackball
> C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 3
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=045e ProdID=001c Rev= 5.00
> C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 64mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
> 
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
> B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.9-gentoo-r1 ehci_hcd
> S:  Product=VIA Technologies, Inc. USB 2.0
> S:  SerialNumber=0000:00:10.3
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

