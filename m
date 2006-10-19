Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946311AbWJSSVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946311AbWJSSVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946309AbWJSSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:21:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:14366 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1423153AbWJSSVL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:21:11 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="147643155:sNHT33987835"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: speedstep-centrino: ENODEV
Date: Thu, 19 Oct 2006 11:21:08 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C1A4AF@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: speedstep-centrino: ENODEV
Thread-Index: AcbzmMYm7yL5IH3mS+ujocT6hpC6xgAAFhow
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jiri Slaby" <jirislaby@gmail.com>
Cc: =?iso-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 19 Oct 2006 18:21:09.0733 (UTC) FILETIME=[59BFB150:01C6F3AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> Also, can both of you send the complete acpidump output from 
>your system. You can find acpidump in latest version of 
>pmtools package here: 
>http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
>
>May be obtained over there:
>
>[...]
>
>>>>> processor, but speedstep-centrino returns ENODEV because of 
>>>>> lack of _PCT et al 
>>>>> entries in DSDT (http://www.fi.muni.cz/~xslaby/sklad/adump). 
>----------------------^^^^
>

Looking at the acpidump, looks like BIOS doesn't have this feature enabled. Can you also make sure you have latest BIOS for the platform and also, check in BIOS whether there are any options to enable this feature.

Thanks,
Venki
