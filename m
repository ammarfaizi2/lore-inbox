Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUFEOHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUFEOHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 10:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUFEOHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 10:07:31 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:57542 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261576AbUFEOHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 10:07:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Date: Sun, 6 Jun 2004 00:07:10 +1000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406060007.10150.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well since 2.6.3 I think I've been getting the record number of 

hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete

errors from my cdrw on hdd; and it's only one drive's worth.


dmesg -s 32768 | grep DataRequest | wc -l
88

Note the -s 32768 is because my dmesg is so long due to the massive number of 
seekcomplete errors :-)

Since the cdrw works fine after re-enabling dma I never really bothered to do 
anything about it, but I'm just curious if anyone has a higher record ;-)

Con
