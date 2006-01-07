Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWAGXPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWAGXPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWAGXPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:15:32 -0500
Received: from tornado.reub.net ([202.89.145.182]:33769 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1161045AbWAGXPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:15:32 -0500
Message-ID: <43C04B93.9020503@reub.net>
Date: Sun, 08 Jan 2006 12:15:31 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>	<43BFD8C1.9030404@reub.net> <20060107133103.530eb889.akpm@osdl.org> <43C03B4A.1060501@reub.net>
In-Reply-To: <43C03B4A.1060501@reub.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself is not a good thing but:

On 8/01/2006 11:06 a.m., Reuben Farrelly wrote:
> 
> 
> On 8/01/2006 10:31 a.m., Andrew Morton wrote:
>> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>> ...
>>> QLogic Fibre Channel HBA Driver
>>> ahci: probe of 0000:00:1f.2 failed with error -12
>>
>> It's odd that the ahci driver returned -EBUSY.  Maybe this is due to "we
>> have legacy mode, but all ports are unavailable" in ata_pci_init_one().
> 
> I've now removed this driver from my .config via menuconfig, I certainly 
> don't have the hardware and have no idea whatsoever how it came to be 
> built in. Although I guess it shouldn't be blowing up even if that is 
> the case?

I thought I'd clear up that I only removed the QLogic driver, and not AHCI ;-)

reuben
