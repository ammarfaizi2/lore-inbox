Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbTCHTYd>; Sat, 8 Mar 2003 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262154AbTCHTYd>; Sat, 8 Mar 2003 14:24:33 -0500
Received: from as12-5-6.spa.s.bonet.se ([217.215.177.162]:31986 "EHLO
	www.tnonline.net") by vger.kernel.org with ESMTP id <S262148AbTCHTYb>;
	Sat, 8 Mar 2003 14:24:31 -0500
Date: Sat, 8 Mar 2003 20:35:08 +0100
From: Anders Widman <andewid@tnonline.net>
X-Mailer: The Bat! (v1.63 Beta/6)
Reply-To: Anders Widman <andewid@tnonline.net>
Organization: TNOnline.net
X-Priority: 3 (Normal)
Message-ID: <1894258031.20030308203508@tnonline.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x IDE: Statis=0x58 - Drive not ready for command
In-Reply-To: <20030308183936.GA3282@vana.vc.cvut.cz>
References: <18084636656.20030308175447@tnonline.net>
 <20030308183936.GA3282@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Mar 08, 2003 at 05:54:47PM +0100, Anders Widman wrote:
>> 
>> I get lots of errors like these:
>> 
>> kernel: PDC202XX: Secondary channel reset.
>> kernel: hdh: drive not ready for command
>> kernel: ide3: reset: success
>> kernel: hdf: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> kernel: hdf: drive not ready for command
>> kernel: hdh: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> kernel: hdh: drive not ready for command
>> kernel: hdh: status timeout: status=0xd0 { Busy }
>> kernel: PDC202XX: Secondary channel reset.
>> kernel: hdh: drive not ready for command
>> kernel: ide3: reset: success
>> 
>> * Running virtually every kernel since 2.4.17-2.4-21-x.
>> * All harddrives UDMA100.
>> * Tried with DMA and unmask IRQ off.
>> * Tried with and without ACPI, APIC and APM.
>> * Happens to all harddrives.
>> * Cabling,  power,  hardware  and drives thorowly checked and replaced
>>   for testing.
>> * Tested with one VIA KT266a motherboard and two Intel 440BX
>> * SMART values good.
>> * To all my testing I have not found any problems with the hardware.
>> * When to many of these IDE error occur the system freezes.
>> * Errors occur with the internal controller as well as the two Promise
>>   PDC20268 (U100 Tx2) controllers.
>> 
>> What  should  I do to fix this? I do not want to run Windows as I need
>> LVM to manage the diskspace. Windows does however run very stable.
>> 
>> Any tips or ideas are welcome!

> On errors you posted there are hdf & hdh. Do not you use slave-only
> configurations? You must not use slave-only with Promise. Never.
>                                                         Petr

Nope. I use 4 drives on both cards.



--------
PGP public key: https://tnonline.net/secure/pgp_key.txt

