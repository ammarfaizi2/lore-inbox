Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263877AbUDFPuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbUDFPt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:49:59 -0400
Received: from bay2-f23.bay2.hotmail.com ([65.54.247.23]:265 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S263877AbUDFPtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:49:39 -0400
X-Originating-IP: [209.172.74.2]
X-Originating-Email: [idht4n@hotmail.com]
From: "David L" <idht4n@hotmail.com>
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: mtd - No flash chips recognised.
Date: Tue, 06 Apr 2004 08:49:35 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F23KWQTHL2bti200002529@hotmail.com>
X-OriginalArrivalTime: 06 Apr 2004 15:49:36.0195 (UTC) FILETIME=[C30F6930:01C41BEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, 2004-04-02 at 08:39 -0800, David L wrote:
> > I'm trying to use 2.6.4 with a Mobile DiskOnChip.  I get the message
> > "No flash chips recognised".  It looks like the DoC_IdentChip function
> > in doc2001.c is finding a nand_flash_id of 0xa5, which isn't one of the
> > ids listed in nand_ids.c.
>
>Er, then it should surely be saying 'No recognised DiskOnChip found' or
>something to that effect?

Here's what it says:

INFTL: inftlcore.c $Revision: 1.14 $, inftlmount.c $Revision: 1.11 $
DiskOnChip Millennium Plus found at address 0xC8000
No flash chips recognised.
Possible DiskOnChip with unknown ChipID FF found at 0xca000
Possible DiskOnChip with unknown ChipID 33 found at 0xcc000
Possible DiskOnChip with unknown ChipID 76 found at 0xce000
Possible DiskOnChip with unknown ChipID 00 found at 0xd0000
Possible DiskOnChip with unknown ChipID 00 found at 0xd2000
Possible DiskOnChip with unknown ChipID FF found at 0xd4000
Possible DiskOnChip with unknown ChipID FF found at 0xd6000
Possible DiskOnChip with unknown ChipID FF found at 0xd8000
Possible DiskOnChip with unknown ChipID FF found at 0xda000
Possible DiskOnChip with unknown ChipID 00 found at 0xdc000
Possible DiskOnChip with unknown ChipID 00 found at 0xde000
Possible DiskOnChip with unknown ChipID FF found at 0xe0000
Possible DiskOnChip with unknown ChipID FF found at 0xe2000
Possible DiskOnChip with unknown ChipID FF found at 0xe4000
DiskOnChip failed TOGGLE test, dropping.
Possible DiskOnChip with unknown ChipID 00 found at 0xe8000
Possible DiskOnChip with unknown ChipID 0F found at 0xea000
Possible DiskOnChip with unknown ChipID 74 found at 0xec000
Possible DiskOnChip with unknown ChipID 00 found at 0xee000

_________________________________________________________________
Free up your inbox with MSN Hotmail Extra Storage! Multiple plans available. 
http://join.msn.com/?pgmarket=en-us&page=hotmail/es2&ST=1/go/onm00200362ave/direct/01/

