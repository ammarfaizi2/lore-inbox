Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVGYVT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVGYVT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGYVT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:19:59 -0400
Received: from fmr15.intel.com ([192.55.52.69]:22679 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261490AbVGYVTz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:19:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Variable ticks
Date: Mon, 25 Jul 2005 17:19:23 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300424AC59@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Variable ticks
Thread-Index: AcWRW/21b92rhU09RrOc/wp7O+kxWQAAg8gA
From: "Brown, Len" <len.brown@intel.com>
To: "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jul 2005 21:19:52.0595 (UTC) FILETIME=[98C55630:01C5915E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>>>Question one, are there other actions to consider?
>> 
>> 
>> Yes.
>> Speaking for ACPI C3 state, note that DMA also
>> wakes up the CPU -- even if there was no device interrupt.
>> (aka, "the trouble with USB")
>
>Trouble? Why would USB do DMA unless there was a device activity?

look here:
http://www.google.com/search?hl=en&q=usb+selective+suspend

Linux is working on it too, but it is in development.

cheers,
-Len
