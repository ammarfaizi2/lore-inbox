Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270011AbRHSTpS>; Sun, 19 Aug 2001 15:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269877AbRHSTpK>; Sun, 19 Aug 2001 15:45:10 -0400
Received: from sub.sonic.net ([208.201.224.8]:15108 "EHLO sub.sonic.net")
	by vger.kernel.org with ESMTP id <S270732AbRHSTo6>;
	Sun, 19 Aug 2001 15:44:58 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sun, 19 Aug 2001 12:44:59 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: mayfield+usb@sackheads.org, mdharm-usb@one-eyed-alien.net
Subject: [PATCH] config options for USB
Message-ID: <20010819124459.F30309@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	mayfield+usb@sackheads.org, mdharm-usb@one-eyed-alien.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed that 2.4.8 introduced Jimme Mayfield's Datafab and Jumpshot USB
drivers.  However, there are no entries in Config.in.  There were also
other new features added (ISD200) that are also missing entries, though
since I don't know anything about them, I didn't create entries for them.


diff -ru linux-2.4.9.orig/drivers/usb/Config.in linux-2.4.9/drivers/usb/Config.in
--- linux-2.4.9.orig/drivers/usb/Config.in	Wed Jun 27 13:59:32 2001
+++ linux-2.4.9/drivers/usb/Config.in	Sun Aug 19 12:29:03 2001
@@ -33,6 +33,8 @@
       bool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG
       bool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM
       bool '    Microtech CompactFlash/SmartMedia reader' CONFIG_USB_STORAGE_DPCM
+      bool '    Datafab MDCFE-B Compact Flash Reader' CONFIG_USB_STORAGE_DATAFAB
+      bool '    Lexar Jumpshot Compact Flash Reader' CONFIG_USB_STORAGE_JUMPSHOT
    fi
    dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
    dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB

-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
