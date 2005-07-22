Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVGVFgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVGVFgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 01:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVGVFgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 01:36:25 -0400
Received: from fmr13.intel.com ([192.55.52.67]:51148 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261832AbVGVFgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 01:36:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux v2.6.13-rc3
Date: Fri, 22 Jul 2005 01:28:24 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30041F358A@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux v2.6.13-rc3
Thread-Index: AcWN3Fen7AusYFvyTcGV4XfFhIuIKAAoT/wA
From: "Brown, Len" <len.brown@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Linus Torvalds" <torvalds@osdl.org>, <acpi-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>,
       "Yu, Luming" <luming.yu@intel.com>, "Greg KH" <greg@kroah.com>
X-OriginalArrivalTime: 22 Jul 2005 05:28:29.0964 (UTC) FILETIME=[31A1D4C0:01C58E7E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Still it would be nice to let people know what to do if they 
>have problems with
>these changes.  Many people don't run -rc kernels and even more people
>don't run -mm, so they have no idea that there are known 
>regressions  ...

I hope the broader exposure will break the EC patch on
another machine (besides your rare Asus) so that we
can figure it out and get it fixed for everybody.

Re: the S3 interrupt resume issue.  We're hoping to fix
the most common drivers before the release ships; and
we'd like to have a method to detect when drivers
do not release their interrupt so that we can at
least have a warning to the user to unload the
offending module until it gets fixed.

thanks for your support,
-Len
