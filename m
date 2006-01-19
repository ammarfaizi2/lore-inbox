Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161276AbWASInf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276AbWASInf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161277AbWASIne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:43:34 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:12307 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1161276AbWASIne convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:43:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Out of Memory: Killed process 16498 (java).
Date: Thu, 19 Jan 2006 08:43:25 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C2703555F85@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Out of Memory: Killed process 16498 (java).
Thread-Index: AcYc1GmD8gB76EyOS1qVvL9C8X/bMg==
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does running the following command cause processes to be killed:

	dd if=/dev/zero of=/u/u1/andyc/tmpfile bs=1M count=8k

And I noticed one of my windows disappeared. Further investigation
showed that was my terminator window (java based app: see
http://software.jessies.org/terminator/). I found this in my syslog:

Jan 17 11:12:58 boco kernel: Out of Memory: Killed process 16498 (java).

My hardware: amd64 based machine (ASUS A8V Deluxe motherboard) with 4Gb
of memory.
My kernel: debian package linux-image-2.6.15-1-amd64-k8 package
installed. IE its running 2.6.15 compiled for amd64.

This is repeatable. The above dd command also causes the machine to
become very unresponsive (eg windows don't focus).
 
-- 
Andy, BlueArc Engineering
