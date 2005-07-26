Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVGZFIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVGZFIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVGZFIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:08:41 -0400
Received: from fmr14.intel.com ([192.55.52.68]:28332 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261732AbVGZFI2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:08:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Power consumption HZ250 vs. HZ1000
Date: Tue, 26 Jul 2005 01:08:16 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300424AE18@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Power consumption HZ250 vs. HZ1000
Thread-Index: AcWRI3e52KprK+6RQJyhmR8FAiSYewAfA1UQ
From: "Brown, Len" <len.brown@intel.com>
To: "Marc Ballarin" <Ballarin.Marc@gmx.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2005 05:08:19.0080 (UTC) FILETIME=[098A9880:01C591A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, this approach is valid.
I've done the exact same measurements for 100HZ vs 1000HZ.
For currently shipping laptops, I didn't see a significant
difference.,

Note that the quality of the instrumentation on
the battery can vary widely, and so if you really
want the best numbers you need to start from a fully
charged battery and run it until the battery dies.

Also, for the most controlled experiment, you can
run in single user mode with no network, no USB plugged
in, and either "performance" or "powersave" governors.
If you don't get into C3 on this box nearly all the time
then something is wrong.

cheers,
-Len

