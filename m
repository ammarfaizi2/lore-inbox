Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbTICKQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 06:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbTICKQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 06:16:36 -0400
Received: from fmr09.intel.com ([192.52.57.35]:64453 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261828AbTICKQd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 06:16:33 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Where do I send APIC victims?
Date: Wed, 3 Sep 2003 06:16:29 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCEC@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Where do I send APIC victims?
Thread-Index: AcNx9S72r5Sy005uR4643vcvAmsJdgADb1ZQ
From: "Brown, Len" <len.brown@intel.com>
To: "Roger Luethi" <rl@hellgate.ch>, <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 03 Sep 2003 10:16:30.0748 (UTC) FILETIME=[719435C0:01C37204]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If interrupts work with acpi=off, but otherwise don't, then:

--begin quote--

Please file a bug at http://bugzilla.kernel.org/
Category: Power Management
Componenet: ACPI

Please attach the output from dmidecide, available in /usr/sbin/, or
here: 
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.

--end quote--

This answer is the same no matter who built the system.

Thanks,
-Len

Ps. Needless to say, this is a hot issue and has become hotter as more
people are enabling ACPI.   There are a number of bugs open on this
topic already with fixes in the works -- so check for dupes.


> -----Original Message-----
> From: Roger Luethi [mailto:rl@hellgate.ch] 
> Sent: Wednesday, September 03, 2003 4:09 AM
> To: linux-kernel@vger.kernel.org
> Cc: acpi-devel@lists.sourceforge.net
> Subject: Where do I send APIC victims?
> 
> 
> As the maintainer of via-rhine, I get bug reports that almost in their
> entirety are "fixed" by turning off APIC and/or ACPI. This 
> has been going
> on for several months now. Every now and then, something 
> promising gets
> posted on LKML, but so far if anything I've seen an 
> _increase_ in those bug
> reports. Maybe a fix is floating around and this will be a 
> non-issue RSN. I
> simply can't tell, since I don't have any IO-APIC hardware to 
> play with.
> 
> Instead of just telling everybody to turn off APIC, I'd like 
> to point bug
> reporters to the proper place and tell them what information 
> they should
> provide so it can get fixed for real. According to 
> MAINTAINERS, Ingo Molnar
> does Intel APIC, but the problems are with VIA chip sets. So 
> where do I
> send my users? Any takers?
> 
> Roger
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
