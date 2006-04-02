Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWDBHva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWDBHva (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 03:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWDBHva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 03:51:30 -0400
Received: from mail-new.archive.org ([207.241.227.188]:3803 "EHLO
	mail.archive.org") by vger.kernel.org with ESMTP id S1751222AbWDBHva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 03:51:30 -0400
Message-ID: <442F827E.8040104@archive.org>
Date: Sat, 01 Apr 2006 23:51:26 -0800
From: Joerg Bashir <brak@archive.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>, ak@suse.de, jgarzik@pobox.com,
       mulix@mulix.org
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
References: <5Mq18-1Na-21@gated-at.bofh.it> <5MqNc-2Y5-3@gated-at.bofh.it> <5MqX4-39H-21@gated-at.bofh.it> <5MyAS-5zh-5@gated-at.bofh.it> <440CD09A.9040005@shaw.ca>
In-Reply-To: <440CD09A.9040005@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Michael Monnerie wrote:
> 
>> On Freitag, 3. März 2006 23:23 Jeff Garzik wrote:
>>
>>> I'll happen but not soon.  Motivation is low at NV and here as well,
>>> since newer NV is AHCI.  The code in question, "NV ADMA", is
>>> essentially legacy at this point -- though I certainly acknowledge
>>> the large current installed base.  Just being honest about the
>>> current state of things...
>>
>>
>> I'd like to raise motivation a lot because most MB sold here (central
>> Europe) are Nforce4 with Athlon64x2 at the moment. It would be nice
>> from vendors if they support OSS developers more, as it's their
>> interest to have good drivers.
> 
> 
> I second that.. It appears that nForce4 will continue to be a popular
> chipset even after the Socket AM2 chips are released, so the demand for
> this (and for NCQ support as well, likely) will only increase.
> 

I'll third it.  Just had another machine blow up it's RAID5 set because
of this bug.  Tyan S2895 board, 4 500GB Hitachi SATA drives in RAID5.  I
suppose I could buy a 3ware controller I suppose but that's a few
hundred dollars per machine.

These machines are running SUSE 9.3 or SUSE 10, I've tried kernel.org
kernels as well as the iommu=memaper=3 cmdline option.

Any other advice greatly appreciated.

I saw a lot of patches come through by Muli but am not sure they address
this issue, do they?

--Joerg


