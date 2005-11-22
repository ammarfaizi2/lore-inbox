Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVKVOJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVKVOJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVKVOJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:09:06 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:55823 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751311AbVKVOJE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:09:04 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <438218E6.4070604@suse.de>
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com> <200511181351.41159.vda@ilport.com.ua> <Pine.LNX.4.61.0511180904470.4215@chaos.analogic.com> <200511191644.03330.vda@ilport.com.ua> <Pine.LNX.4.61.0511211246390.14321@chaos.analogic.com> <438218E6.4070604@suse.de>
X-OriginalArrivalTime: 22 Nov 2005 14:09:01.0337 (UTC) FILETIME=[49CA6890:01C5EF6E]
Content-class: urn:content-classes:message
Subject: Re: Compaq Presario "reboot" problems
Date: Tue, 22 Nov 2005 09:09:00 -0500
Message-ID: <Pine.LNX.4.61.0511220905410.11943@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compaq Presario "reboot" problems
Thread-Index: AcXvbknR27CmcfyfRzS7mAujwLtviQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Stefan Seyfried" <seife@suse.de>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>, <vda@ilport.com.ua>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Nov 2005, Stefan Seyfried wrote:

> linux-os (Dick Johnson) wrote:
>
>> I don't know how to make `reboot` or `init 0` take the required
>> parameters! I don't know how to get from user-mode into the kernel
>> code with any such parameters. I looked through `proc` and couldn't
>> find anything for such parameters either:
>>
>> Script started on Mon 21 Nov 2005 12:42:11 PM EST
>> [root@chaos root]# reboot=cb
>> [root@chaos root]# strace reboot=cb
>> strace: reboot=cb: command not found
>> [root@chaos root]# strace reboot -cb
>
> Pass it to the kernel at the bootloader prompt. Like the "vga=6" and
> "root=/foo/bar" you have somewhere in there.
>
> --
> Stefan Seyfried                  \ "I didn't want to write for pay. I
> QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
> SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
>

Okay, the results are the same. The machine reboots. It doesn't
run the memory-test so it probably didn't cold-boot. It's hard to
tell with these lap-tops because the time in the BIOS is so
brief. Anyway, it reboots into Linux, but can't reboot into Windows
as before.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
