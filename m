Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbVIVFvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbVIVFvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 01:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVIVFvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 01:51:32 -0400
Received: from fmr13.intel.com ([192.55.52.67]:4997 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S965231AbVIVFvb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 01:51:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] bogus #if (acpi/blacklist)
Date: Thu, 22 Sep 2005 01:50:57 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3004AA5C50@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] bogus #if (acpi/blacklist)
Thread-Index: AcW/NLh6Q0+wFi32RjGOJu/c56BfvQABNspg
From: "Brown, Len" <len.brown@intel.com>
To: "Al Viro" <viro@ftp.linux.org.uk>, "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <zippel@linux-m68k.org>, <viro@ZenIV.linux.org.uk>, <Eric.Piel@lifl.fr>,
       <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Sep 2005 05:50:59.0548 (UTC) FILETIME=[9BA881C0:01C5BF39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied.

thanks,
-Len 

>-----Original Message-----
>From: Al Viro [mailto:viro@ftp.linux.org.uk] 
>Sent: Thursday, September 22, 2005 1:16 AM
>To: Randy.Dunlap
>Cc: Brown, Len; zippel@linux-m68k.org; 
>viro@ZenIV.linux.org.uk; Eric.Piel@lifl.fr; torvalds@osdl.org; 
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] bogus #if (acpi/blacklist)
>
>On Wed, Sep 21, 2005 at 10:14:26PM -0700, Randy.Dunlap wrote:
>>  obj-y				+= tables.o
>> +ifdef CONFIG_X86
>>  obj-y				+= blacklist.o
>> +endif
>
>More common form would be
>
>obj-$(CONFIG_X86)	+= blacklist.o
>
