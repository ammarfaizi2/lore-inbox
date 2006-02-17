Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWBQHjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWBQHjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbWBQHjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:39:25 -0500
Received: from pcsbom.patni.com ([203.124.139.208]:23224 "EHLO
	pcsspz.PATNI.COM") by vger.kernel.org with ESMTP id S1161150AbWBQHjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:39:24 -0500
Reply-To: <srikanth.venkataraman@patni.com>
From: "Srikanth Venkataraman" <srikanth.venkataraman@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Issue in using more number of devices with BFS setup in AS4
Date: Fri, 17 Feb 2006 13:15:53 +0530
Message-ID: <NMEJJEMLNDGCKHIMAMIFAEIDDDAA.srikanth.venkataraman@patni.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1140162300-14420-16"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20060216.230318.21310500.davem@davemloft.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1140162300-14420-16
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

We have a Boot from SCSI setup and we are facing some problem. Problem
description is given below

System configuration: -
OS: AS4 UPDATE 1  [2.6.9-11.ELsmp]
Memory:  1 GB
QLA2310 Driver Info: Driver version 8.00.00b21-k, Firmware version 3.03.02
IPX
Setup: Boot From SCSI

Scenario 1:
Devices: 1024 SCSI devices
Utility gives the problem: /sbin/hotplug
Observation: udev process hangs and after some time kernel panic occurs.

Scenario 2:
Devices: 512
Utility:/sbin/hotplug
Observation: Boot from San success.

Scenario 3:
Devices: 1024
Utility: /sbin/udevsend
Observation: Boot from San success


Can any one answer the following queries: -

    1. Are 512, the maximum number of devices that can be supported in Boot
from San in AS4 with hotplug agent?
    2. If not what is the hardware requirement for more devices to be
supported or how it can be rectified?
    3. Can we use utility /sbin/udevsend instead of /sbin/hotplug. Will it
impact any other process or devices?
    4. Is /sbin/udevsend and /sbin/hotplug similar in functionality.

Thanks & Regards,
Srikanth Venkataraman.




http://www.patni.com
World-Wide Partnerships. World-Class Solutions.
_____________________________________________________________________

This e-mail message may contain proprietary, confidential or legally
privileged information for the sole use of the person or entity to
whom this message was originally addressed. Any review, e-transmission
dissemination or other use of or taking of any action in reliance upon
this information by persons or entities other than the intended
recipient is prohibited. If you have received this e-mail in error
kindly delete  this e-mail from your records. If it appears that this
mail has been forwarded to you without proper authority, please notify
us immediately at netadmin@patni.com and delete this mail. 
_____________________________________________________________________

------------=_1140162300-14420-16--
