Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130367AbRAHRO5>; Mon, 8 Jan 2001 12:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRAHROr>; Mon, 8 Jan 2001 12:14:47 -0500
Received: from z211-19-80-61.dialup.wakwak.ne.jp ([211.19.80.61]:15612 "EHLO
	220fx.luky.org") by vger.kernel.org with ESMTP id <S130367AbRAHROg>;
	Mon, 8 Jan 2001 12:14:36 -0500
To: linux-kernel@vger.kernel.org
Subject: typo in linux-2.2.18/Documentation/usb/usb-serial.txt
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Canyonlands)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010109022407R.shibata@luky.org>
Date: Tue, 09 Jan 2001 02:24:07 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000414(IM141)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried to use USB-SERIAL converter shown in 
http://www.century.co.jp/products/usb_serial1a.html
that uses Prolific chip.

Prolific USB2SERIAL is not supported yet,
so I tried to "generic".
Then I found typo in the document.

Here is a tiny patch.

     BTW. I can not use prolific U2S yet.
     Any comments?


--- usb-serial.txt~     Tue Jan  9 02:12:55 2001
+++ usb-serial.txt      Tue Jan  9 02:13:30 2001
@@ -196,7 +196,7 @@
   
   To enable the generic driver to recognize your device, build the driver
   as a module and load it by the following invocation:
-       insmod usb-serial vendor=0x#### product=0x####
+       insmod usbserial vendor=0x#### product=0x####
   where the #### is replaced with the hex representation of your device's
   vendor id and product id.

Best Regards,
Hisaaki Shibata

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki Shibata JAPAN
0(mmm)0 P-mail: 070-5419-3233    IRC: #luky
   ~    http://his.luky.org/ last update:2000.3.12
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
