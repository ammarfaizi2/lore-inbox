Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTLLTAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTLLTAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:00:09 -0500
Received: from outmail.nrtc.org ([204.145.144.17]:30298 "EHLO
	exchange.nrtc.coop") by vger.kernel.org with ESMTP id S261799AbTLLTAH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:00:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: 2.4.23 is freezing my systems hard after 24-48 hours
Date: Fri, 12 Dec 2003 14:00:07 -0500
Message-ID: <F7F4B5EA9EBD414D8A0091E80389450569D3C9@exchange.nrtc.coop>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.23 is freezing my systems hard after 24-48 hours
Thread-Index: AcPA4ibmK5gi8xAUSbWYc1P9AihMZg==
From: "Jeremy Kusnetz" <JKusnetz@nrtc.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've read that enabling ip-chains compatibility would cause this, but I do not have this feature enabled at all.

I have a cluster of 8 servers all doing the same thing that I upgraded to a stock 2.4.23 kernel, after that period of time one random one will lock up hard.  No output to screen, can't sysrq or anything, only physically hitting the power button can get me out of it.  I've gotten nothing in any of my logs to give any indication on what's going on.

They don't seem to come when the server is under load, but more on how long the server has been up.  Actually I do have this kernel running in my development environment, but none of those machines have ever locked up, it seems they need some load to eventually cause this to happen.

I had been running 2.4.20 with no problems before the upgrade.

I haven't tried running a bk series kernel yet, in the mean time I've downgraded to 2.4.22 with the do_brk patch.  I haven't had this kernel up long enough to see if it will crash.
