Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTDLSGw (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 14:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbTDLSGw (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 14:06:52 -0400
Received: from f11.pav1.hotmail.com ([64.4.31.11]:1033 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S263349AbTDLSGv (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 14:06:51 -0400
X-Originating-IP: [66.32.101.73]
X-Originating-Email: [jim_jim33@hotmail.com]
From: "jim beam" <jim_jim33@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: USB Mass Storage Device
Date: Sat, 12 Apr 2003 18:18:31 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F11gAPf1MieZutGvO8n00005049@hotmail.com>
X-OriginalArrivalTime: 12 Apr 2003 18:18:32.0275 (UTC) FILETIME=[ECAB0230:01C3011F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello group,

The following USB Mass Storage device is found during bootup:

scsi0 : SCSI emulation for USB
Mass Storage devices
  Vendor: SOYO      Model: USB Storage-SMC   Rev: 0214
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

Is it a CompactFlash reader that plugs directly into a USB1 header on my 
motherboard.

/sys/bus/scsi/devices/0:0:0:0/* contains information regarding the device, 
however there is nothing /dev/scsi/host0/bus0/target0/lun0 for me to mount, 
regardless of whether there is a card in the drive or not.  I have hotplug 
enables, and inserting a card in the drive does not generate any new 
messages under dmesg (although verbosity stuff is not enabled).  Is this 
device not yet supported, or am I missing something that I need to enable?

Thanks,
Jim




_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*.  
http://join.msn.com/?page=features/featuredemail

