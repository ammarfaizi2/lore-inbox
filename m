Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVG1SkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVG1SkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVG1Shg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:37:36 -0400
Received: from fmr15.intel.com ([192.55.52.69]:37014 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261935AbVG1SgL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:36:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: VIA PCI routing problem
Date: Thu, 28 Jul 2005 14:36:00 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30042CFE47@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: VIA PCI routing problem
Thread-Index: AcWTbVX5GJgy4eS6T9auuMf1dQPWUgANYgEw
From: "Brown, Len" <len.brown@intel.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Jul 2005 18:36:02.0476 (UTC) FILETIME=[34CD76C0:01C593A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Sorry in taking so long to track this down. I just got motivated
>today.
>
>I have a VIA SMP system and somewhere between 2.6.12-rc3 and 2.6.12
>the USB mouse started moving around really slowly. Anyway, it turns
>out that the attached patch (against 2.6.13-rc3-git8) fixes 
>the problem.
>
>Let me know if any info is needed or if you would like me to test a
>patch.
>
>This is a regression versus 2.6.11 so it would be good to have a fix in
>2.6.13.

Fix two systems, break another...

Nick, can you open a bugzilla on this and put your lspci -vv
and dmesg into it.  Apparently the quirk is good for some
machines and not as good for others and we need to get smarter
about when to apply it.

thanks,
-Len
