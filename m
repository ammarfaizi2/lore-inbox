Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUCRRUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbUCRRUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:20:15 -0500
Received: from fmr05.intel.com ([134.134.136.6]:1977 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262794AbUCRRUE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:20:04 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Linux Kernel Microcode Question
Date: Thu, 18 Mar 2004 09:19:42 -0800
Message-ID: <7F740D512C7C1046AB53446D3720017301118F87@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux Kernel Microcode Question
Thread-Index: AcQNB/7wYG3KGIkQRgu9qrCM3DwUQQAAjSlw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Justin Piszcz" <jpiszcz@hotmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Mar 2004 17:19:43.0803 (UTC) FILETIME=[3465A8B0:01C40D0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A microcode update is used to correct errata in the processor, and the
facility is part of the architecture, as written in the manual. As Dave
pointed out, if the BIOS has the latest one, the OS does not need to do
anything. 

We are working with Tigran closely, and we have provided the latest
updates to him very recently. He will try them out first, and then
publish the new updates for public consumption. Stay tuned.

Jun

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Justin Piszcz
>Sent: Thursday, March 18, 2004 8:41 AM
>To: linux-kernel@vger.kernel.org
>Subject: Linux Kernel Microcode Question
>
>The URL: http://www.urbanmyth.org/microcode/
>
>The microcode_ctl utility is a companion to the IA32 microcode driver
>written by Tigran Aivazian <tigran@veritas.com>. The utility has two
uses:
>
>    * it decodes and sends new microcode to the kernel driver to be
>uploaded
>to Intel IA32 processors. (Pentium Pro, PII, PIII, Pentium 4, Celeron,
Xeon
>etc - all P6 and above, which does NOT include pentium classics)
>    * it signals the kernel driver to release any buffers it may hold
>
>The microcode update is volatile and needs to be uploaded on each
system
>boot i.e. it doesn't reflash your cpu permanently, reboot and it
reverts
>back to the old microcode.
>
>My question is, what are the advantages vs disadvantages in updating
your
>CPU's microcode?
>
>Is it worth it?
>
>Does it matter what type of Intel CPU you have?
>
>Do some CPU's benefit more than others for microcode updates?
>
>I know RedHat distributions usually do this by default, but others do
not.
>
>Can anyone explain reasons to or not to update the CPU microcode?
>
>_________________________________________________________________
>FREE pop-up blocking with the new MSN Toolbar - get it now!
>http://clk.atdmt.com/AVE/go/onm00200415ave/direct/01/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
