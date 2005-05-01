Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVEABCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVEABCU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 21:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVEABCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 21:02:20 -0400
Received: from easyspace.ezspl.net ([216.74.109.141]:63973 "EHLO
	easyspace.ezspl.net") by vger.kernel.org with ESMTP id S261482AbVEABCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 21:02:15 -0400
Message-ID: <1114909346.42742aa2a8926@www.nucleodyne.com>
Date: Sat, 30 Apr 2005 21:02:26 -0400
From: kallol@nucleodyne.com
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: LSI Logic's Ultra320 320-4X RAID adapter
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 63.111.213.196
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - easyspace.ezspl.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 32001] / [47 12]
X-AntiAbuse: Sender Address Domain - nucleodyne.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,
      We have been evaluting different IO adapters for a storage system vendor.

LSI logic's 320-4X RAID controller seems to be a good choice.

There is an issue with the system on which we are measuring performance.
The memory space PCI register access can not be used.

Question #1: Does 320-4X support IO Space device register access?
Question #2: Do we have a linux driver for it that supports IO ports also?

The megaraid linux driver seems to check the BAR0, if it is memory bar then mem
space is used otherwise IO space.

May be the adapter supporting memory space also support IO space access.


Thanks,
Kallol
