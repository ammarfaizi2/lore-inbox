Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTDDPAp (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 10:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263744AbTDDO7f (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:59:35 -0500
Received: from mail.explainerdc.com ([212.72.36.220]:44455 "EHLO
	mail.explainerdc.com") by vger.kernel.org with ESMTP
	id S263741AbTDDOy2 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 09:54:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: RAID 5 performance problems
Date: Fri, 4 Apr 2003 17:05:56 +0200
Message-ID: <73300040777B0F44B8CE29C87A0782E101FA98E7@exchange.explainerdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID 5 performance problems
Thread-Index: AcL6tiiQqMkAxRCQTlmMI0K2fApzvAABXr2g
From: "Jonathan Vardy" <jonathan@explainerdc.com>
To: "Ezra Nugroho" <ezran@goshen.edu>
Cc: "Peter L. Ashford" <ashford@sdsc.edu>,
       "Jonathan Vardy" <jonathanv@explainerdc.com>,
       "Stephan van Hienen" <raid@a2000.nu>, <linux-raid@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ezra Nugroho [mailto:ezran@goshen.edu] 

> Your hdc is still running at udma(33). This is also part of the raid,
> right? This will slow the whole thing down since in raid 5 
> write is done
> to all disks simultaneously. Before the system finishes writing to the
> slow drive, the write is not done yet.

 > Your hdc is still running at udma(33). This is also part of the raid,
> right? This will slow the whole thing down since in raid 5 
> write is done
> to all disks simultaneously. Before the system finishes writing to the
> slow drive, the write is not done yet.

This should not cripple the performance to what I get. My friend had
6x80GB 5400rpm drives with two of those on udma33 and four on udma66 and
he managed 80MB/sec (dual 500Mhz)

Jonathan
