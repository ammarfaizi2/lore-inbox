Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWCQTln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWCQTln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWCQTln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:41:43 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:44972 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S1751221AbWCQTlm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:41:42 -0500
X-OB-Received: from unknown (205.158.62.232)
  by wfilter.us4.outblaze.com; 17 Mar 2006 19:42:47 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "martin schneebacher" <masc@operamail.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: sdhci-devel@list.drzeus.cx
Date: Fri, 17 Mar 2006 20:42:46 +0100
Subject: new sdhci driver
X-Originating-Ip: 85.125.216.214
X-Originating-Server: ws5-11.us4.outblaze.com
Message-Id: <20060317194247.1641ECA0A4@ws5-11.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

the sdhci driver works fine here at this aopen barebook 1559as, i haven't experienced any problems while accessing/inserting/removing the card. even udev/hal/gnome-volume-manager works fine with it. the writing speed isn't that good, but at least it works without errors.
i have kernel  2.6.16-rc6-mm1 on a updated debian/unstable installed.
controller is the (lspci)

0000:06:09.3 Mass storage controller: Texas Instruments PCIxx21 Integrated FlashMedia Controller
0000:06:09.4 0805: Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller

there are no errors nor warnings in the syslog, just 
Mar 17 20:28:06 gusti kernel: mmcblk0: mmc2:014d S008B 6640KiB 
Mar 17 20:28:06 gusti kernel:  mmcblk0: p1
when inserting the card. the only card i have is a panasonic 8MB SD card. 


bye...masc.



-- 
_______________________________________________
Surf the Web in a faster, safer and easier way:
Download Opera 8 at http://www.opera.com

Powered by Outblaze
