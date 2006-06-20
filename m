Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWFTWUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWFTWUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWFTWUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:20:41 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:33739 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751286AbWFTWUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:20:40 -0400
Message-ID: <449874B6.7020606@dgreaves.com>
Date: Tue, 20 Jun 2006 23:20:38 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, jgarzik@pobox.com
Subject: Re: LibPATA/ATA Errors Continue - Will there be a fix for this?
References: <Pine.LNX.4.64.0606200808250.5851@p34.internal.lan> <4497F1C7.2070007@rtr.ca> <449804EA.8030908@dgreaves.com> <44981800.2000807@dgreaves.com> <Pine.LNX.4.64.0606201146430.2601@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0606201146430.2601@p34.internal.lan>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Dave, what is the make/model of the drives you get errors with by the
> way?
>
> On Tue, 20 Jun 2006, David Greaves wrote:
>> [Some email archaeology later]
>>
>> Back in March I was running 2.6.16 (with the opcode patch) and I sent an
>> email with the following info:
>>
>> dmesg:
>> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/04 to SCSI
>> SK/ASC/ASCQ 0xb/00/00
>> ata1: status=0x51 { DriveReady SeekComplete Error }
>> ata1: error=0x04 { DriveStatusError }
Model Family: Maxtor DiamondMax 10 family
Device Model: Maxtor 6B200M0
Serial Number: B4038RRH
Firmware Version: BANC1980

this is sata_sil

Another machine has :
Device Model: SAMSUNG SP2504C
Serial Number: S09QJ10Y720963
Firmware Version: VT100-33
User Capacity: 250,059,350,016 bytes

running through sata_via

that's running 2.6.16.18 and just gives:
ata1: PIO error
ata1: status=0x50 { DriveReady SeekComplete }


David

-- 

