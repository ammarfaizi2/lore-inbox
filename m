Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWH0Qxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWH0Qxf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWH0Qxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:53:35 -0400
Received: from mga03.intel.com ([143.182.124.21]:63338 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932181AbWH0Qxe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:53:34 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,174,1154934000"; 
   d="scan'208"; a="108238376:sNHT17447738"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.18-rc4-mm3
Date: Sun, 27 Aug 2006 09:53:31 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454800B93@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.18-rc4-mm3
Thread-Index: AcbJ8eUboUE+95aXRL2gaRGmfE5ncwABofXg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Benoit Boissinot" <bboissin@gmail.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 27 Aug 2006 16:53:33.0775 (UTC) FILETIME=[550F65F0:01C6C9F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK. This is the second system on which failure has happened. Can you
please send me the acpidump output (You can get latest pmtools from here
- http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/ ).
Unfortunately I am not able to reproduce this failure on my local
systems yet. I will try to find out what may be going wrong.

Andrew: Can you revert the below patch until the issue is resolved.

Thanks,
Venki

>-----Original Message-----
>From: Benoit Boissinot [mailto:bboissin@gmail.com] 
>Sent: Sunday, August 27, 2006 9:00 AM
>To: Andrew Morton
>Cc: linux-kernel@vger.kernel.org; Pallipadi, Venkatesh; Brown, Len
>Subject: Re: 2.6.18-rc4-mm3
>
>On 8/27/06, Andrew Morton <akpm@osdl.org> wrote:
>>
>> 
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
>.6.18-rc4/2.6.18-rc4-mm3/
>>
>>  git-acpi.patch
>
>commit f62d31ee2f2f453b07107465fea54540cab418eb broke my laptop
>(pentium M, dell D600).
>I can reliably get a hard lockup (no sysrq) when modprobing ehci_hcd
>and uhci_hci. It works when reverting the changeset.
>
>I can provide cpuinfo or dmesg if necessary.
>
>regards,
>
>Benoit
>
