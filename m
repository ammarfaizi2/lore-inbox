Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266580AbUHQSp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266580AbUHQSp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUHQSp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:45:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:27098 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266580AbUHQSpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:45:17 -0400
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel 2.6.8.1 and Minolta Dimage-7HI
Date: Tue, 17 Aug 2004 20:45:16 +0200
User-Agent: KMail/1.7
Cc: warpy@gmx.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408172045.16386.warpy@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here i'm use Gentoo, udev, hotplug.

My Minolta Dimage-7HI will not work with the latest 2.6.8.1 and 2.6.8.1-mm1 
Kernel.

Log says

Aug 17 17:05:18 stargate kernel: usb-storage: probe of 1-2:1.0 failed with 
error -1
Aug 17 17:09:13 stargate kernel: usb 1-2: USB disconnect, address 3
Aug 17 17:10:17 stargate kernel: usb 1-2: new full speed USB device using 
address 4
Aug 17 17:10:17 stargate kernel: usb-storage: probe of 1-2:1.0 failed with 
error -1
Aug 17 17:12:56 stargate kernel: usb 1-2: USB disconnect, address 4
Aug 17 17:13:31 stargate kernel: usb 1-2: new full speed USB device using 
address 5
Aug 17 17:13:31 stargate kernel: usb-storage: probe of 1-2:1.0 failed with 
error -1
Aug 17 17:13:57 stargate kernel: usb 5-1: USB disconnect, address 2
Aug 17 17:14:29 stargate kernel: usb 1-2: USB disconnect, address 5
Aug 17 17:14:45 stargate kernel: usb 1-2: new full speed USB device using 
address 6
Aug 17 17:14:45 stargate kernel: usb-storage: probe of 1-2:1.0 failed with 
error -1

cat /proc/bus/usb/devices

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0686 ProdID=400f Rev= 0.01
S:  Manufacturer=MINOLTA  DIMAGE CAMERA
S:  Product=DIMAGE CAMERA
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E:  Ad=03(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=  16 Ivl=0ms

Driver=(none) :-(

with Kernel 2.6.7 all works fine.

-- 
Michael Geithe

-
