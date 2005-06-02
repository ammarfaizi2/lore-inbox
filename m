Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVFBJgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVFBJgk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVFBJgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:36:39 -0400
Received: from ribosome.natur.cuni.cz ([195.113.57.20]:19341 "EHLO
	ribosome.natur.cuni.cz") by vger.kernel.org with ESMTP
	id S261337AbVFBJgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:36:21 -0400
Message-ID: <429ED313.3080704@ribosome.natur.cuni.cz>
Date: Thu, 02 Jun 2005 11:36:19 +0200
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en, en-us, cs
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-git6 mis-counted ide interfaces
References: <429ECE20.1030403@ribosome.natur.cuni.cz> <20050602033253.77cd66d9.akpm@osdl.org>
In-Reply-To: <20050602033253.77cd66d9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz> wrote:
> 
>>  I get the following when I boot my PIIX computer (Asus P4C800E-Deluxe):
>>
>>
>> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>> ide: Assuming 66MHz system bus speed for PIO modes
>> ICH5: IDE controller at PCI slot 0000:00:1f.1
>> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
>> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
>> ICH5: chipset revision 2
>> ICH5: not 100% native mode: will probe irqs later
>>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
>> Probing IDE interface ide0...
> 
>                          ^^^^ Here's ide0
> 
> 
>> hda: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
>> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>> Probing IDE interface ide1...
>> ----------------------^^^^ ide0 I believe
> 
> 
> Does the kernel boot and run OK, or does something actually go wrong?

It works fine, just the *extra* "Probing IDE interface ide1..." line made me
worry about.
Martin
