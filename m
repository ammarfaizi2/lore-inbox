Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVGUHvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVGUHvC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 03:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVGUHvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 03:51:01 -0400
Received: from amdext4.amd.com ([163.181.251.6]:64901 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S261675AbVGUHu7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 03:50:59 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Content-class: urn:content-classes:message
Subject: Multi-threaded IO performance regression on 2.6 kernel?
Date: Thu, 21 Jul 2005 15:48:18 +0800
MIME-Version: 1.0
Message-ID: <1784BBD8D1F15B4C9FB0F09F0A939F9001A3E463@SZEXMTA4.amd.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Multi-threaded IO performance regression on 2.6 kernel?
Thread-Index: AcWNyLTu2sPCSz1JQFSdT6zj0Y739g==
From: "Xie, Bill" <bill.xie@amd.com>
To: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 21 Jul 2005 07:50:45.0090 (UTC)
 FILETIME=[E68CF420:01C58DC8]
X-WSS-ID: 6EC18C572CC3912044-01-01
Content-Type: text/plain;
 charset=gb2312
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I am testing the multi-threaded IO performance on Opteron servers. 

I use dd as the test tools. The single dd can reach 60MBps for single disk.

on 2.6.5 kernel, If dd numbers exceed the CPU numbers, vmstat bi reduced to 20MBps.

on 2.4.21 kernel, multi-threaded IO performance works fine, even I run 40 dd command at same time.

Does anybody experienced similar issue also?

Best Regards
Bill Xie

