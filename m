Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUBCAHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUBCAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:07:52 -0500
Received: from hb6.lcom.net ([216.51.236.182]:21120 "EHLO
	petrus.dynamic.digitasaru.net") by vger.kernel.org with ESMTP
	id S261957AbUBCAHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:07:44 -0500
Date: Mon, 2 Feb 2004 18:07:36 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI breakage in 2.6.2-rc3 (and before)
Message-ID: <20040203000732.GA6376@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0020AEAEA@hdsmsx402.hd.intel.com> <1075664452.2394.5.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075664452.2394.5.camel@dhcppc4>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Len Brown on Sunday, 01 February, 2004:
>Joseph,
>Please try this patch
>http://bugzilla.kernel.org/attachment.cgi?id=1965&action=view
>from this bug report:
>http://bugzilla.kernel.org/show_bug.cgi?id=1766
>It should be in the next mm patch, and if it causes no regression will
>be pushed to 2.6.2.
>thanks,
>-Len

Patch works!  I just applied and tested, and it worked great.
What magic does that patch work?
Thanks!

-Joseph

>On Sun, 2004-02-01 at 15:19, Joseph Pingenot wrote:
>> From Linus Torvalds on Friday, 30 January, 2004:
>> >The bulk of this is an ACPI update, but there's USB, ia-64, i2c, XFS
>> and
>> >PCI hotplug updates here too.
>> >Please don't send in anything but critical fixes until after the
>> final
>> >2.6.2 release.
>> Hmm.  I just tried 2.6.2-rc3 (after having tried 2.6.1 after having
>>   tried 2.6.2-rc2-mm1), and I note that ACPI can get my battery
>>   status in 2.6.1, but *not* in 2.6.2-rc2-mm1 or in 2.6.2-rc3.
>>   It notes that there is a battery in one of the two bays, and
>>   that it's on battery or AC power, but nothing more; all status
>>   readouts say that the battery's drained.
>> System is a Dell Inspiron 8600.
>> Thanks!
