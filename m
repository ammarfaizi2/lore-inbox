Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbTJST1v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTJST1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:27:51 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:23231 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S262064AbTJST1p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:27:45 -0400
Message-ID: <48981.192.168.9.10.1066591663.squirrel@ncircle.nullnet.fi>
In-Reply-To: <006b01c39667$f32211c0$0514a8c0@HUSH>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>   
    <48236.192.168.9.10.1066565636.squirrel@ncircle.nullnet.fi>   
    <006501c39660$cf306cf0$0514a8c0@HUSH>
    <40464.192.168.9.10.1066583818.squirrel@ncircle.nullnet.fi>
    <006b01c39667$f32211c0$0514a8c0@HUSH>
Date: Sun, 19 Oct 2003 22:27:43 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> Very interesting. The other type of errors I have received (the last
>> time
>> with 2.4.23-pre4) were:
>>
>> Sep 14 14:29:49 alderan kernel: hde: set_drive_speed_status: status=0xff
>> {
>> Busy }
>> Sep 14 14:29:49 alderan kernel: blk: queue c0492188, I/O limit 4095Mb
>> (mask 0xffffffff)
>
> Same here.
>
>> Currently my disk-drivers are made by 2*samsung (SV8004H) and
>> 2*Samsung(SV1604N), in case that changes anything.
>
> I'm using two seagates (different models), one Samsung and one Maxtor,
> this happens in all 4.
> I'm not using any kind of RAID.

Hmm, if I checked correctly, your motherboard (Asus CUSL2) doesn't seem to
include a HPT374 based (integrated) IDE-controller. Are you using some
add-on PCI-card for IDE ? If yes, are you using older style Parallel-ATA
or newer Serial-ATA interface ?

>>
>> And have you tried with ACPI on/off and io-apic on/off ?
>
> No, to be honest I didn't even think of this. You think it could make a
> difference? Given the fact that the card works correctly with the HPT
> drivers, pretty much everything that does not relate directly to the IDE
> drivers seems ruled out as the cause...

Based on previous questions and answers on this list, those settings
might very well affect you, as they affect the way interrupts are handled
in your system. Unfortunately, they haven't fixed my problems no matter
what I combination I have tried.

Regards,
Tomi Orava

-- 
Tomi.Orava@ncircle.nullnet.fi
