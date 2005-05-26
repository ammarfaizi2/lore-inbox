Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVEZLlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVEZLlC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 07:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVEZLlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 07:41:02 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:57512 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261315AbVEZLky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 07:40:54 -0400
Date: Thu, 26 May 2005 07:40:52 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: logfile for an svcd creation session
To: linux-kernel@vger.kernel.org
Message-id: <200505260740.52831.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Running 2.6.12-rc4, I made several video cd's of a wedding yesterday, 
and did not note this till looking at logwatch this morning:

 --------------------- Kernel Begin ------------------------ 

WARNING:  Kernel Errors Present
   Buffer I/O error on device hdc, l...:  62 Time(s)
   end_request: I/O error, dev hdc, sector...:  198 Time(s)
   hdc: command error: error=0x54 { Ab...:  198 Time(s)
   hdc: command error: status=0x51 { D...:  198 Time(s)

 ---------------------- Kernel End ------------------------- 

The SVCD's play just fine in a commercial dvd player.

The burner, /dev/hdc is, from dmesg:
hdc: LITE-ON DVDRW LDW-451S, ATAPI CD/DVD-ROM drive
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

This drive has not had the firmware upgrade.  DMA is working.
Burnproof was off for the last 3 copies, buffer was never under 98% 
according to k3b.

Ideas anyone?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
