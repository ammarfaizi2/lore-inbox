Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWGYRDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWGYRDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 13:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWGYRDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 13:03:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:17984 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932101AbWGYRDp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 13:03:45 -0400
X-IronPort-AV: i="4.07,180,1151910000"; 
   d="scan'208"; a="103931750:sNHT2748013457"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI bombing, ACPI Exception (acpi_bus-0071): AE_NOT_FOUND
Date: Tue, 25 Jul 2006 12:44:06 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6010E42CF@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI bombing, ACPI Exception (acpi_bus-0071): AE_NOT_FOUND
Thread-Index: Acav/z4VV0KohRxLTeW+cEPhpxkpgQAAdOcQ
From: "Brown, Len" <len.brown@intel.com>
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       "George Nychis" <gnychis@cmu.edu>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <akpm@osdl.org>
X-OriginalArrivalTime: 25 Jul 2006 16:44:08.0683 (UTC) FILETIME=[8C9B73B0:01C6B009]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Hey guys,
>> 
>> I am running a 2.6.18-rc1-git7 kernel on my IBM Thinkpad x60s, with
>> CONFIG_ACPI_DOCK=y
>> 
>> Whenever the computer is inserted into the dock, ACPI seems to bomb:
>> http://rafb.net/paste/results/GW5E8747.html
>> 
>> I was wondering if anyone could help me solve this problem, 
>I believe it
>> is keeping me from using my cdrom drive on the dock since it does not
>> show up in /dev.  I have also contacted Kristen Accardi 
>about it, who I
>> believe wrote the dock code... but I wasn't sure if this is a further
>> problem in ACPI somewhere.
>> 
>> Here is my full config:
>> http://rafb.net/paste/results/o2gSVu90.html
>> 
>> Thanks!
>> George

>Hello everyone,
>I am working on getting an x60 to duplicate the cdrom issue 
>this week.  However, I was wondering if there was anything we 
>could do about these AE_NOT_FOUND messages.  A lot of people 
>believe that they are errors, but in fact they are normal for 
>hotplugging.  Would it be ok if I just get rid of that error 
>message?  It generates unneccessary consternation.

In 2.6.17, this was a DEBUG message.
I'll return it to being a DEBUG message for 2.6.18.

BTW. I can't follow the URLs above, hopefully you can.
stashing logs in a bugzilla entry is generally a better method,
because "bugzilla never forgets".

thanks,
-Len
