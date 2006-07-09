Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbWGIT7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWGIT7J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWGIT7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:59:09 -0400
Received: from mga03.intel.com ([143.182.124.21]:18593 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161100AbWGIT7H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:59:07 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="scan'208"; a="63356839:sNHT20806569"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI_DOCK bug: noone cares
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 9 Jul 2006 15:59:03 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF9CF@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI_DOCK bug: noone cares
Thread-Index: Acajci4Cm/Brxv+lQquGYFP84dSYaQAGziAg
From: "Brown, Len" <len.brown@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Adrian Bunk" <bunk@stusta.de>
Cc: "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       "Dave Hansen" <haveblue@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       "LKML" <linux-kernel@vger.kernel.org>, <gregkh@suse.de>,
       <linux-acpi@vger.kernel.org>, "Miles Lane" <miles.lane@gmail.com>
X-OriginalArrivalTime: 09 Jul 2006 19:59:06.0224 (UTC) FILETIME=[22468F00:01C6A392]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Two weeks ago, we had:
>> - a bug report
>> - a detailed description how to possibly fix this issue
>> 
>> What we did NOT have was:
>> - any reaction by the patch author or any maintainer
>>   (although with the exception of Linus, the recipients of 
>the problem
>>    description were exactly the same as the ones in this email)

Yes, I'm on this list.
No, I don't see all patches or comments unless they get sent directly
to: or cc: to me.

>> A few days later, the patch that includes this bug was included in 
>> Linus' tree.
>> 
>> Two weeks later, the bug is still present in both latest -mm 
>and Linus' 
>> tree.
>> 
>> Linus, please do a
>>   git-revert a5e1b94008f2a96abf4a0c0371a55a56b320c13e
>
>Fair enough. Reverted.

I disagree with this decision, and would like to know what
is necessary to reverse it.

>I think I'll stop accepting any ACPI patches at all that add 
>new features, as long as there doesn't seem to be anybody who reacts to

>bug-reports. We  don't need ACPI features.

If it is a requirement that I see every patch sent to the list
and not directly to me during weekends in July, then I agree
with your decision -- because I can't give you that level of service.
But surely:

1. You can e-mail me directly when you are asking me to do something.
2. deleting the driver is a somewhat Draconian response to what appears
 to be a simple Kconfig issue in rc1.

>We need somebody who answers when people like Andrew asks 
>about patches to support things like memory hotplug (which was also a
problem 
>over the last weeks). Here's a quote from Andrew from a week or so ago:

>"repeat seven times over three months with zero response.".

The memhotplug patches first hit the list March 21st -- the 1st day of
the 2.6.17 integration window.

I would have queued them for 2.6.18-rc1, but they depended
on other patches in -mm that Andrew did not send me.

Yes, I Should have mentioned that to Andrew, and acked
the patches so he could have sorted that out.

However, the only way they could have got into 2.6.18-rc1 any
earlier would be if the 2.6.17 cycle were shorter.

>It's not worth it to accept new stuff if we know it's not 
>going to get any attention ever afterwards.

If you address me directly when you are asking me to do something,
that would really help me help you.

thanks,
-Len
