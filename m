Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbTIPWdl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 18:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbTIPWdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 18:33:41 -0400
Received: from fmr99.intel.com ([192.55.52.32]:42674 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262534AbTIPWdj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 18:33:39 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI fixes
Date: Tue, 16 Sep 2003 12:37:09 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FD7D@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI fixes
Thread-Index: AcN70TmajEH2b1RkR5i041OE7lmsvQAnBhKQ
From: "Brown, Len" <len.brown@intel.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>
Cc: "Andrew de Quincey" <adq_dvb@lidskialf.net>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>
X-OriginalArrivalTime: 16 Sep 2003 16:37:11.0836 (UTC) FILETIME=[C74C65C0:01C37C70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
Yes, these are integrated, I'll update the version# and send you a pull
request later today.

Note the new URL:

http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23

Is the tree dedicated for you to do pulls into 2.4.23

http://linux-acpi.bkbits.net/linux-acpi-test-2.4.23

Is the test tree where we'll stage things before dropping them into the
release tree.  We'll cook Andrew's change here.

There are 2.4.22 versions of these trees also, for people who want the
latest ACPI backported into 2.4.22.  (actually I don't back-port, I
integrate into the 2.4.22 tree and then pull forward into the 2.4.23
tree)

Thanks,
-Len

> -----Original Message-----
> From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com.br] 
> Sent: Monday, September 15, 2003 2:34 PM
> To: linux-kernel@vger.kernel.org
> Cc: Brown, Len; Andrew de Quincey
> Subject: ACPI fixes
> 
> 
> 
> Len, 
> 
> What about merging this patches in linux-acpi.bkbits.com ?
> 
> They seem to be in the ACPI tree for some time now.
> 
> ASUS A7V BIOS version 1011 from  blacklist (Eric Valette)
> support non ACPI compliant SCI over-ride  specs (Jun Nakajima)
> Fix ACPI oops on ThinkPad T32/T40 (Shaohua 
> Extended IRQ resource type for nForce (Andrew 
> Handle BIOS with _CRS that fails (Jun Nakajima)
> 
> Andrew, your fallback to PIC mode patch seems to be doing 
> well, right? 
> 
> Did you try to get it into the ACPI tree?  
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
