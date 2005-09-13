Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbVIMNUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVIMNUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 09:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbVIMNUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 09:20:15 -0400
Received: from magic.adaptec.com ([216.52.22.17]:21914 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S964771AbVIMNUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 09:20:13 -0400
Message-ID: <4326D206.4050100@adaptec.com>
Date: Tue, 13 Sep 2005 09:20:06 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 2/14] sas-class: README
References: <4321E4DD.7070405@adaptec.com> <43238C16.4010709@torque.net> <4325B333.3070301@adaptec.com> <43269A7A.3080602@torque.net>
In-Reply-To: <43269A7A.3080602@torque.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 13:20:12.0084 (UTC) FILETIME=[DEE75F40:01C5B865]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 05:23, Douglas Gilbert wrote:
> Luben Tuikov wrote:
>>The questiong is _what_ to do on this event.  This is a complex
>>answer and I'd rather have a _SES_ layer (or at least a logical
>>module/library) to handle those as storage vendors want this,
>>_right now_.
> 
> 
> Simple answer: generate a hotplug event and let a
> user application that cares worry about it. No
> need for a SES layer in the kernel.

Well, that sounds ok, but it maybe the case that the SES
device wants to say something about the SAS devices
on the same level.  So even if userspace gets it, it would
have nothing to do with it, because of the _type_ of SES
device/event/etc.
(User space can be notified anyway, which is perfectly fine).

>>In fact, I've some patches to submit regarding SES devices
>>on the domain, but I wanted to _trim *down*_ the politics,
>>_not_ escalate them.
> 
> 
> Oh no, not a sysfs representation of SES abstractions :-)

No, not that.

	Luben

