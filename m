Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWB0CrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWB0CrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 21:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWB0CrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 21:47:25 -0500
Received: from fmr20.intel.com ([134.134.136.19]:33926 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751267AbWB0CrY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 21:47:24 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: 2.6.16-rc4-mm2 configs
Date: Sun, 26 Feb 2006 21:47:07 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30062E9D71@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc4-mm2 configs
Thread-Index: AcY7Qj1Jm6O4/kHBRoKr44S+25EPfgABajCg
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Feb 2006 02:47:10.0167 (UTC) FILETIME=[1AE70670:01C63B48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> a.  why does SONY_ACPI default to m ?  Other similar options 
>are default n.
>
>Because I got heartily sick of losing the setting each time I 
>went back to a mainline kernel and did `make oldconfig'.

IIR the recommendation from Roman on these things was
to remove the default entirely.  If you have a favorite
.config file with =m in it, then make oldconfig should
preserve that choice.

-Len
