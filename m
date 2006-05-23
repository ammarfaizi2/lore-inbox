Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWEWOLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWEWOLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWEWOLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:11:48 -0400
Received: from amdext4.amd.com ([163.181.251.6]:13509 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932092AbWEWOLs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:11:48 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: cpu hotplug sleeping from invalid context
Date: Tue, 23 May 2006 09:12:32 -0500
Message-ID: <B3870AD84389624BAF87A3C7B8314993029358EC@SAUSEXMB2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpu hotplug sleeping from invalid context
Thread-Index: AcZ+LFCVxF0QVFtXTBCZH+5UQbS1AgARlTbQ
From: "shin, jacob" <jacob.shin@amd.com>
To: "Ashok Raj" <ashok.raj@intel.com>, "Dave Jones" <davej@redhat.com>
cc: "Linux Kernel" <linux-kernel@vger.kernel.org>, akpm@osdl.org
X-OriginalArrivalTime: 23 May 2006 14:12:33.0779 (UTC)
 FILETIME=[EF98FC30:01C67E72]
X-WSS-ID: 686DC7D827K1524833-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 23, 2006 12:42 AM Ashok Raj wrote:
> On Mon, May 22, 2006 at 11:35:34AM -0700, Dave Jones wrote:
>> 
>>    (2.6.17rc4-git9)
>> 
>>    echo 0 > /sys/devices/system/cpu/cpu1/online
>>    echo 1 > /sys/devices/system/cpu/cpu1/online
>> 
>>    on my dual-core notebook gets me this:
>> 
> 
> I was just purging my inbox this morning, and saw a similar report
> from Jacob Shin in the x86-64 discuss list. When i checked with
> him, he replied that this is now resolved. I didnt ask what it
> was... Jacob could you send a pointer to the fix?

http://lkml.org/lkml/2006/4/28/142

It was a simply null pointer fix.

-Jacob

