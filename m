Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUHXA3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUHXA3p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269061AbUHXA13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:27:29 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:29143 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S268209AbUHXA0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 20:26:24 -0400
Message-ID: <007601c48971$7c3c68a0$0300a8c0@r000000>
From: "turbanator1" <turbanator1@verizon.net>
To: <linux-kernel@vger.kernel.org>
References: <ILECKIIBJKFNIHNBJHEJOENJCBAA.ayotunde_itayemi@gtbplc.com>
Subject: Re: what causes this error please (APIC)
Date: Mon, 23 Aug 2004 20:29:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.202.65.187] at Mon, 23 Aug 2004 19:26:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Ayotunde Itayemi" <ayotunde_itayemi@gtbplc.com>
To: <marcelo@hera.kernel.org>; <linux-kernel@vger.kernel.org>;
<bjorn.helgaas@hp.com>; <khali@linux-fr.org>; <marcelo@logos.cnet>;
<jones@ingate.com>
Cc: <funadej@yahoo.com>
Sent: Monday, August 23, 2004 5:47 PM
Subject: what causes this error please (APIC)


> Hi Marcel, Hi All,
>
> Please a colleague is trying to setup RH Linux 7.2 on a very old 486
> (100Mhz)  RAM = 53MB. HDD = 4GB
> It startsup, when it tries to load:"loading initrd.img............" It
comes
> up with an error;
>
> Kernel Panic: Attemted to kill the idle task - not syncing
> Linux noapic will not work
>
> I suggested turning off/on any ACPI stuff's in the BIOS?
> I have searched on the web but most references are to stuffs changed in
> kernel version 2.4.x etc
>
> It seems APIC has something to do with ACPI or IRQ management/allocation?
> Is there anything to be done to get the RH 7.2 to install on this box or
> there is no hope at all?
>
> I am sorry for the disjointed "flow" of this mail, it's because I am
running
> against time - it's
> 10:40PM here! The Internet link is a little flaky too, but I will see wat
I
> can find (again)
> on the Web tomorrow.
>
> Hope to hear from you soon. Thanks.

ACPI is not APIC. APIC is the Advanced Programmable Interrupt Controller,
which allows one or multiple processors to handle multiple interrupts. ACPI
however, is related to power management. A 486 is probably too old to
support either. You should probably turn both features off.

