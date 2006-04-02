Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWDBIYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWDBIYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWDBIYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:24:30 -0400
Received: from mail-new.archive.org ([207.241.227.188]:65208 "EHLO
	mail.archive.org") by vger.kernel.org with ESMTP id S932152AbWDBIY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:24:29 -0400
Message-ID: <442F8A3A.9000305@archive.org>
Date: Sun, 02 Apr 2006 00:24:26 -0800
From: Joerg Bashir <brak@archive.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@mulix.org>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@suse.de,
       jgarzik@pobox.com
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
References: <5Mq18-1Na-21@gated-at.bofh.it> <5MqNc-2Y5-3@gated-at.bofh.it> <5MqX4-39H-21@gated-at.bofh.it> <5MyAS-5zh-5@gated-at.bofh.it> <440CD09A.9040005@shaw.ca> <442F827E.8040104@archive.org> <20060402080035.GA7856@granada.merseine.nu>
In-Reply-To: <20060402080035.GA7856@granada.merseine.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Sat, Apr 01, 2006 at 11:51:26PM -0800, Joerg Bashir wrote:
> 
> 
>>I saw a lot of patches come through by Muli but am not sure they address
>>this issue, do they?
> 
> 
> No, I'm afraid not - our patches are to support a different
> IOMMU, and it looks like this problem is gart specific. I'll go dig
> through the archive, but is there consensus on how to solve this bug
> and it's just a question of doing the work, or is the root cause
> unknown?

I'm unsure.  Here is an earlier message from this thread with info and a
glimmer of hope.


------------------------------------

Andi Kleen wrote:

> On Friday 03 March 2006 22:27, Allen Martin wrote:
>
>
>> nForce4 has 64 bit (40 bit AMD64) DMA in the SATA controller.  We gave
>> the docs to Jeff Garzik under NDA.  He posted some non functional driver
>> code to linux-ide earlier this week that has the 64 bit registers and
>> structures although it doesn't make use of them.  Someone could pick
>> this up if they wanted to work on it though.
>
>
>
> Thanks for the correction. Sounds nice - hopefully we'll get a driver
soon.
> I guess it's in good hands with Jeff for now.


I'll happen but not soon.  Motivation is low at NV and here as well,
since newer NV is AHCI.  The code in question, "NV ADMA", is essentially
legacy at this point -- though I certainly acknowledge the large current
installed base.  Just being honest about the current state of things...

    Jeff

> 
> Cheers,
> Muli

