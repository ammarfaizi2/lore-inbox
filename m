Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTD3V11 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTD3V11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:27:27 -0400
Received: from 16022821.rjo.virtua.com.br ([200.160.228.21]:29579 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262437AbTD3V1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:27:25 -0400
Content-Type: text/plain; charset=utf-8; format=flowed
To: linux-kernel@vger.kernel.org
From: Mauricio Oliveira Carneiro <carneiro@tecgraf.puc-rio.br>
MIME-Version: 1.0
Date: Wed, 30 Apr 2003 18:39:41 -0300
Message-ID: <oprogo4fzred667r@localhost>
User-Agent: Opera7.10/Linux M2 build 388
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm almost hanging myself.. it's been a week trying without success :-( 
Maybe someone here could help me out. Sorry for the disturbance ! 

I have bought a USB FLASH MEMORY device from Kmit Co. The model is : "Unity 
ITS". I bought it from FRY's Electronics in Palo Alto, CA (USA)
 
It works perfectly with windows, but i'm having problems with linux 2.4.20- 
9 kernel.
 
It detects the existance of the USB FLASH MEMORY device, as of my 
/proc/bus/usb/device file says :
 
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 98mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=16 #Cfgs=  1
P:  Vendor=09a6 ProdID=8001 Rev= 1.00
S:  Manufacturer=KMIT CO.,LTD
S:  Product=KM USB Removable Disk
S:  SerialNumber=20021226113657-00
 
 
At the /proc/scsi/usb-storage-0/0 file I get :
 
   Host scsi0: usb-storage
       Vendor: KMIT CO.,LTD
      Product: KM USB Removable Disk
Serial Number: 20021226113657-00
     Protocol: 8070i
    Transport: Bulk
         GUID: 09a68001002122fffffff600
     Attached: Yes
 
 
In /etc/mtab :
 
usbdevfs on /proc/bus/usb type usbdevfs (rw)
 


But I can't see it mounted anywhere in my system, nor can I mount it by 
hand since I don't know the device filename (/dev/?) .
 
 
I believe it works the same way for every flash memory drive.

if someone have already suffered of the same cause, I thank for the help :)
 
Mauricio Oliveira Carneiro
 
