Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135603AbRALWrE>; Fri, 12 Jan 2001 17:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135609AbRALWqy>; Fri, 12 Jan 2001 17:46:54 -0500
Received: from sc-66-27-47-84.socal.rr.com ([66.27.47.84]:519 "EHLO
	falcon.bellfamily.org") by vger.kernel.org with ESMTP
	id <S135603AbRALWqo>; Fri, 12 Jan 2001 17:46:44 -0500
Message-ID: <3A5F8956.9040305@bellfamily.org>
Date: Fri, 12 Jan 2001 14:46:46 -0800
From: "Robert J. Bell" <rob@bellfamily.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: USB Mass Storage in 2.4.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know there has been some talk arround this topic on this list so If I 
missed the answer I apologize, i just joined the list today. I read 
through the archive and all I could find relative to mass storage is the 
scsi dependancy, which I am aware of. Here is my situation.

I have a Fujufilm FX-1400 digital camera that uses the USB Mass Storage 
driver. I know it works because I had it working in 2.4.0-test12, and in 
2.4.0 however I had a major system failure and lost my new kernel. This 
time arround I can not get USB Mass Storage to work. I have tried 
various combinations of the scsi and usb options. I thought maybe I 
needed SCSI Disk support as well but it didnt seem to matter. I have 
tried with scsi and usb mass storage as modules and as part of the 
kernel, still no luck. Here is what happens when I connect the camera :

Jan 10 18:49:05 t20 kernel: hub.c: USB new device connect on bus1/1, 
assigned device number 3
Jan 10 18:49:05 t20 kernel: Product: USB Mass Storage
Jan 10 18:49:05 t20 kernel: SerialNumber: Y-170^^^^^000810X0000003005237
Jan 10 18:49:06 t20 kernel: scsi0 : SCSI emulation for USB Mass Storage 
devices
Jan 10 18:49:06 t20 kernel:   Vendor:  `.À ÀòÏ  Model: \206   Ø\177.À¡# 
À ÝòÏ  Rev: ÿÿÿÿ
Jan 10 18:49:06 t20 kernel:   Type:   Scanner                            
ANSI SCSI revision: 02

Now this used to detect a scsi disk and all I had to do was mount it. I 
am sure there must be other conflicting config options but I just dont 
know what it could be. Any help would be greatly appreciated.

Robert.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
