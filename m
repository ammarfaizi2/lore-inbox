Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272242AbTHRTVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272291AbTHRTVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:21:30 -0400
Received: from fmr02.intel.com ([192.55.52.25]:2292 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S272242AbTHRTVP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:21:15 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ASUS PR-DLSW: ACPI Bugs
Date: Mon, 18 Aug 2003 15:21:07 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC6E@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ASUS PR-DLSW: ACPI Bugs
Thread-Index: AcNkUqOLTbip03g/R1Cnp+OniUHeUgBYYgmQ
From: "Brown, Len" <len.brown@intel.com>
To: "Erich Stamberger" <eberger@gewi.kfunigraz.ac.at>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Aug 2003 19:21:13.0105 (UTC) FILETIME=[E32C2010:01C365BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See that you've got the latest BIOS -- Asus's web page advertises 1008:
http://www.asus.com/support/download/item.aspx?ModelName=PR-DLSW

If acpi=off is still required to boot, then file a bug at
http://bugzilla.kernel.org category=Power Management; Component=ACPI;
Owner=len.brown@intel.com

Then I'll ask you:
1. can you try the latest 2.6 kernel -- it has slightly newer ACPI code.
2. can you attach the output of acpidmp:
http://developer.intel.com/technology/iapc/acpi/downloads/pmtools-200107
30.tar.gz
3. can you attch the output of dmidecode:
http://www.nongnu.org/dmidecode/

Thanks,
-Len




> -----Original Message-----
> From: Erich Stamberger [mailto:eberger@gewi.kfunigraz.ac.at] 
> Sent: Saturday, August 16, 2003 7:57 PM
> To: linux-kernel@vger.kernel.org
> Subject: ASUS PR-DLSW: ACPI Bugs
> 
> 
> Hello,
> 
> 2.6.0-test3 with ACPI enabled fails to boot on ASUS PR-DLSW: Cannot
> open root device .. Obviously the SCSI controllers (LSI 1010-66)
> are not detected (complete dmesg from serial console below).
> 
> When setting pci=noacpi the machine hangs in an endless loop
> trying to initialise the SCSI bus.
> 
> With acpi=off or CONFIG_ACPI_HT_ONLY the machine
> boots (lspci -vvx below).
> 
> Any information / pointers will be appreciated.
> 
> Best regards
> Erich
> 
