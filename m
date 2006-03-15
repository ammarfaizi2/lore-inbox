Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWCOWaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWCOWaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWCOWaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:30:55 -0500
Received: from mail.gurulabs.com ([67.137.148.7]:48025 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S932158AbWCOWay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:30:54 -0500
Subject: Warning - Maxtor SATA II and Nvidia nforce4
From: Dax Kelson <dax@gurulabs.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 15:31:27 -0700
Message-Id: <1142461887.2521.44.camel@station14.example.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short version
==============
Nvidia Nforce4 chipset with Maxtor SATA II drives with certain firmware
revisions cause data corruption and system instability when under
moderate to heavy I/O load.

After being suspected for over a year, it was acknowledged just in the
last few weeks, see:

http://maxtor.custhelp.com/cgi-bin/maxtor.cfg/php/enduser/std_adp.php?p_faqid=2685

(there is a list of affected HD model numbers and HD firmware versions)

If it is possible to determine the firmware version, maybe some printk
warnings could be generated.

Long version
=============

About a year ago I got a new home uber system all decked out.

AMDFX-55
Nforce4 SLI motherboard
2GB RAM
300GB Maxtor SATA II HDD x2 (model 6B300S with firmware BANC1B70)

Off and on I have experienced the following problems:

* kernel panics
* freezes
* insta-reboots
* on-board RAID (nforce fake raid) de-syncing
* LCD blinking on and off (most common symptom for me)
* segfaults and application crashes

The problems were not continuous and would seemingly erratically
appear. 

My memory tested fine with memtest86+ over repeated tests the past 12
months. I RMA'd my video cards and got a new motherboard. I was
contemplating swapping my CPU when I finally did a Google search on
"Maxtor nforce4" and my eyes were opened. Pages and pages of posts in
hundreds of different forums.

Dax Kelson

