Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265537AbUFZAF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265537AbUFZAF4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 20:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUFZAFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 20:05:55 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:329 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S265537AbUFZAFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 20:05:53 -0400
Message-ID: <40DCBDCC.4070405@travellingkiwi.com>
Date: Sat, 26 Jun 2004 01:05:32 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: No APIC interrupts after ACPI suspend
References: <1088160505.3702.4.camel@tyrosine>
In-Reply-To: <1088160505.3702.4.camel@tyrosine>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:

>If I do an S3 suspend, my machine resumes correctly (Thinkpad X40,
>acpi_sleep=s3_bios passed on the command line). If I have the ioapic
>enabled, however, I get no interrupts after resume. Hacking in a call to
>APIC_init_uniprocessor in the resume path improves things - I get edge
>triggered interrupts, but anything flagged as level triggered doesn't
>work. How can I get the ioapic fully initialised on resume?
>  
>
I have an identical problem with an r50p. But I'm running PIC... 
(Because the r50p doesn't seem to do APIC). Not sure if it's identical, 
but after resuming, I get maybe 10 seconds of sound, OR 30 odd minutes 
of networking (I know... Sounds strange)... Then neither...

H
