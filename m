Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTJSTOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTJSTOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:14:39 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:27836 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S262108AbTJSTOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:14:35 -0400
Message-ID: <48232.192.168.9.10.1066590873.squirrel@ncircle.nullnet.fi>
In-Reply-To: <yw1x3cdpgm46.fsf@users.sourceforge.net>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>
    <1066579176.7363.3.camel@milo.comcast.net><41102.192.168.9.10.1066584247.squirrel@ncircle.nullnet.fi>
    <yw1x3cdpgm46.fsf@users.sourceforge.net>
Date: Sun, 19 Oct 2003 22:14:33 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi> writes:
>
>>> In 2.4.21 and 2.4.22 it's working great for me.  I'm using the
>>> "experimental" IDE Raid with two disks on a HPT 374 controller with the
>>> drivers that come with the kernel.
>>
>> I have tried these versions in the past as well without success.
>> However, I don't use HPT-raid features at all ie. I'm using the
>> disks as JBOD. What hardware do you have and have you enabled
>> ACPI/local-apic/io-apic ? What brand & model of disk-drives you
>> are using with HPT374 controller ? And finally what does
>> the /proc/interrupts show for you ?
>
> I'm using a RocketRAID 1540 SATA card (hpt374 based) in an Alpha
> system.  It has no such thing as ACPI.  The disks are four Seagate
> Barracuda 7200.7 running software raid5.  My /proc/interrupts:

Ok, that might be one reason why it's working for you but not for me.
If I've understood correctly, people who have problems with HPT374
are using the integrated Parallel-ATA interface instead of SATA.

I'd be really interested to hear if anyone has a working system
with kernel included drivers & HPT374-controller integrated in
motherboard and using PATA-drives ?

Regards,
Tomi Orava




