Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbSI0Tj3>; Fri, 27 Sep 2002 15:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262601AbSI0TjW>; Fri, 27 Sep 2002 15:39:22 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:3086 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262598AbSI0TjA>;
	Fri, 27 Sep 2002 15:39:00 -0400
Date: Fri, 27 Sep 2002 12:42:40 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927194240.GE12909@kroah.com>
References: <20020927193723.GA12909@kroah.com> <20020927193855.GB12909@kroah.com> <20020927194025.GC12909@kroah.com> <20020927194054.GD12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927194054.GD12909@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611.1.3 -> 1.611.1.4
#	drivers/usb/storage/unusual_devs.h	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/26	brihall@pcisys.net	1.611.1.4
# [PATCH] Update for JMTek USBDrive
# 
# Attached is a patch against the 2.4.19 linux kernel. It adds an entry
# for another version of the JMTek USBDrive (driverless), and also updates
# my email address.
# --------------------------------------------
#
diff -Nru a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h	Fri Sep 27 12:30:19 2002
+++ b/drivers/usb/storage/unusual_devs.h	Fri Sep 27 12:30:19 2002
@@ -548,17 +548,22 @@
 		US_SC_SCSI, US_PR_BULK, NULL,
 		US_FL_MODE_XLATE | US_FL_START_STOP | US_FL_FIX_INQUIRY ),
 
-/* Submitted by Brian Hall <brihall@bigfoot.com>
+/* Submitted by Brian Hall <brihall@pcisys.net>
  * Needed for START_STOP flag */
 UNUSUAL_DEV(  0x0c76, 0x0003, 0x0100, 0x0100,
 		"JMTek",
 		"USBDrive",
 		US_SC_SCSI, US_PR_BULK, NULL,
 		US_FL_START_STOP ),
+UNUSUAL_DEV(  0x0c76, 0x0005, 0x0100, 0x0100,
+		"JMTek",
+		"USBDrive",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_START_STOP ),
 
 /* Reported by Dan Pilone <pilone@slac.com>
  * The device needs the flags only.
- * Also reported by Brian Hall <brihall@bigfoot.com>, again for flags.
+ * Also reported by Brian Hall <brihall@pcisys.net>, again for flags.
  * I also suspect this device may have a broken serial number.
  */
 UNUSUAL_DEV(  0x1065, 0x2136, 0x0000, 0x9999,
