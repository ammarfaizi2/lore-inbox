Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbUKQGPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUKQGPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 01:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbUKQGPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 01:15:39 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:63162 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262182AbUKQGPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 01:15:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Old thread: Nobody cared, chapter 10^3rd
Date: Wed, 17 Nov 2004 01:15:21 -0500
User-Agent: KMail/1.7
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>
References: <200411150052.22271.gene.heskett@verizon.net> <200411152250.25036.gene.heskett@verizon.net> <200411160905.24277.bjorn.helgaas@hp.com>
In-Reply-To: <200411160905.24277.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411170115.22085.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.52.50] at Wed, 17 Nov 2004 00:15:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 November 2004 11:05, Bjorn Helgaas wrote:
>On Monday 15 November 2004 8:50 pm, Gene Heskett wrote:
>> On Monday 15 November 2004 17:16, Len Brown wrote:
>> >Any difference when you tested with "pci=routeirq"?
>>
>> Dunno Len, but I'll add that to grub.conf and reboot for effects.
>> BRB.
>>
>> Well, it shut that particular message off, but it sure made ACPI
>> noisy!
>
>I think we're just rediscovering the floppy and i8042 issues that we
> found and fixed in -mm a while back.  The i8042 patch is contained
> in here:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
>0-rc2/2.6.10-rc2-mm1/broken-out/bk-input.patch
>
Silly Q: I tried to mount a vfat floppy the other day and couldn't, 
will this patch also fix that?

>I have no idea whether this will apply directly to Linus' kernel, or
>whether it depends on other patches, but it should fix the problem.

I'll go get it and see if it will apply. If not, then it probably 
should be redone against the 10-rc2 tree and republished.

Now a couple of hours later (I got sidetracked) & saved this in 
drafts...

Well, it did apply to 2.6.10-rc2, and I'm running it now.  Without the 
arguements on the kernel command line in grub.conf.

ACPI is still very noisy in dmesg though.  But nothing to report in 
the way of errors, it just does a lot of chattering.  Great for 
debugging no doubt.

Now, lets see if I can mount a vfat floppy disk, that was a problem 
before.

Yup, works as expected now, thanks a bunch.

Sane still works, tvtime still works, xmms still plays oggs, kde is 
running fine, I'm a happy camper again.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
