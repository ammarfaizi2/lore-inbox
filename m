Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTKKQ30 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 11:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTKKQ30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 11:29:26 -0500
Received: from 0x503e3f58.boanxx7.adsl-dhcp.tele.dk ([80.62.63.88]:42757 "HELO
	mail.hswn.dk") by vger.kernel.org with SMTP id S264329AbTKKQ3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 11:29:25 -0500
Date: 11 Nov 2003 16:29:22 -0000
Message-ID: <20031111162922.1702.qmail@osiris.hswn.dk>
To: thomas@habets.pp.se
Cc: linux-kernel@vger.kernel.org
Orig-To: Thomas Habets <thomas@habets.pp.se>
Subject: Re: PROBLEM: Memory leak in -test9?
References: <E1AJahk-00011D-00@reptilian.maxnet.nu>
From: Henrik Storner <henrik@hswn.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There seems to be a memory leak in 2.6.0-test9. Before I go on I'll mention 
>that the box is running Debian sarge (testing), and the compiler is gcc 3.3.1.

>A lot of memory is used (and eventually it will crash), but very little is in 
>cache or buffers. After shutting down zebra, postgresql, snmp and apache this 
>is what the system looked like. Notice the Slab-size in /proc/meminfo.

The data from the /proc/slabinfo would be helpful in tracking down
which part of the kernel is using the memory.


Henrik
-- 
Henrik Storner <henrik@hswn.dk> 
