Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTKHKM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 05:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTKHKM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 05:12:26 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:28343 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S261683AbTKHKMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 05:12:25 -0500
Message-ID: <3FACC17C.7070901@backtobasicsmgmt.com>
Date: Sat, 08 Nov 2003 03:12:12 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@redhat.com>
Subject: libata testing on new machine with ICH5 and PDC20318
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm building a new server to go into a colo facility in about six weeks; 
the machine will have an Intel motherboard with an ICH5R (although I 
won't use the RAID features) and a Promise SATA150 TX4 (no RAID 
support). All six SATA ports will have Seagate 160GB Barracuda drives 
attached, and I plan on using software RAID-5 and LVM2 on top of the array.

I will be building the system using 2.6.0-test9, so will be using libata 
to drive the disks. If there's anything I can help with 
debugging/testing the ICH and/or Promise SATA drivers let me know... I 
see that recently Jeff posted a small patch for some SATA reset issues 
against -test9, so I'll certainly start out with that included.

