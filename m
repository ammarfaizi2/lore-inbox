Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbTIVR23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbTIVR23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:28:29 -0400
Received: from [62.118.80.130] ([62.118.80.130]:27380 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S263253AbTIVR20 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:28:26 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: HT not working by default since 2.4.22
Date: Mon, 22 Sep 2003 13:28:03 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC86E1@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HT not working by default since 2.4.22
Thread-Index: AcOA556R/x1SkaJzSxeabzLyC7aEAgAPCOCQ
From: "Brown, Len" <len.brown@intel.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 22 Sep 2003 17:28:07.0358 (UTC) FILETIME=[E3028DE0:01C3812E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

If somebody has a 2.4.22 system where CONFIG_ACPI_HT_ONLY plus zero
cmdline parameters doesn't result in HT running and no ACPI running,
then please forward the details directly to me.

Thanks,
-Len

Ps. CONFIG_ACPI_HT_ONLY "CPU Enumeration Only" is under the CONFIG_ACPI
menu at the request of Red Hat, who wanted to be able to disable
anything to do with ACPI with a single option (CONFIG_ACPI).  HT depends
on this part of ACPI b/c the logical HT processors are enumerated using
the ACPI MADT LAPIC entries.

> -----Original Message-----
> From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com.br] 
> Sent: Monday, September 22, 2003 5:01 AM
> To: linux-kernel@vger.kernel.org; Brown, Len; Alan Cox
> Subject: HT not working by default since 2.4.22
> 
> 
> 
> Hi,
> 
> Ive received a few complaints that HT, starting from 2.4.22, 
> needs ACPI
> enabled. Users who had HT working now have to use ACPI and they didnt
> before.
> 
> We should have HT working AUTOMATICALLY without ACPI enabled 
> and WITHOUT
> any special boot option, as before.
> 
> Please lets fix that up
> 
> Len?
> 
> 
> 
> 
