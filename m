Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbUCDCP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 21:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUCDCP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 21:15:59 -0500
Received: from nobody.lpr.e-technik.tu-muenchen.de ([129.187.151.1]:30429 "EHLO
	nobody.lpr.e-technik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S261402AbUCDCP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 21:15:57 -0500
Message-ID: <40469242.70406@metrowerks.com>
Date: Thu, 04 Mar 2004 03:19:46 +0100
From: Bernhard Kuhn <bkuhn@metrowerks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] real-time interrupts for linux 2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everybody!

I hope that i can steal enough of your precious time to get
your attention for a patch that adds hard real time support
to the linux kernel (worst case response time below
5 microseconds at a 100 KHz periodic interrupt).

The proposed "real time interrupt patch" enables the linux
kernel for hard-real-time applications such as data aquisition
and control loops by adding priorities to interrupts and spinlocks.

New festures since first release
--------------------------------

* ported to 2.6 (tested with 2.6.2 and 2.6.3)
* io-apic priority operation partly implemented
* enhanced example application
* performed benchmarks


The following document will describe the patch in detail and how
to install it:

http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040304/rtirq.html


The patch and a demo application can be downloaded from:

http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040304/rtirq-2.6.2-20040304.tar.bz2


Comments are highly appreciated!


best regards

Bernhard Kuhn



P.S.: i had some troubles (re)subscribing to LKML, so i guess i'm
posting off-list. Please put me on CC in case you reply to the list,
THX and sorry.


