Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTKEXSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 18:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTKEXSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 18:18:35 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:42208 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263292AbTKEXSd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 18:18:33 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [DMESG] cpumask_t in action
Date: Wed, 5 Nov 2003 15:18:29 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB58023A6@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [DMESG] cpumask_t in action
Thread-Index: AcOj68hrmSzTAYxZR3miQNng0Mqq8AABUAoQ
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Jesse Barnes" <jbarnes@sgi.com>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 05 Nov 2003 23:18:30.0587 (UTC) FILETIME=[2001B8B0:01C3A3F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dentry cache hash table entries: 33554432 (order: 14, 268435456 bytes)
> Inode-cache hash table entries: 33554432 (order: 14, 268435456 bytes)
> IP: routing cache hash table of 8388608 buckets, 131072Kbytes
> TCP: Hash tables configured (established 67108864 bind 65536)
> swapper: page allocation failure. order:17, mode:0x20

Does these hash tables really need to that big? 33 million dentry and
inode
entry? Same thing with network, unless the machine is loaded with
several
gigabit cards, these hash table seems to be exceedingly large.
