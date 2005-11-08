Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbVKHWQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbVKHWQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVKHWQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:16:35 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:36369 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030330AbVKHWQf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:16:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1131487518.2789.26.camel@laptopd505.fenrus.org>
References: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com> <1131487518.2789.26.camel@laptopd505.fenrus.org>
X-OriginalArrivalTime: 08 Nov 2005 22:16:33.0438 (UTC) FILETIME=[139E4BE0:01C5E4B2]
Content-class: urn:content-classes:message
Subject: Re: Creating new System.map with modules symbol info
Date: Tue, 8 Nov 2005 17:16:33 -0500
Message-ID: <Pine.LNX.4.61.0511081712210.6019@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Creating new System.map with modules symbol info
Thread-Index: AcXkshPCmaraLmNqTlWh3PvNv9ixHg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Adayadil Thomas" <adayadil.thomas@gmail.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Nov 2005, Arjan van de Ven wrote:

> On Tue, 2005-11-08 at 16:04 -0500, Adayadil Thomas wrote:
>> Greetings.
>>
>> The System map that was created when compiling kernel does'nt have the symbols
>> of modules that are loaded later. How can I create a new System.map
>> with the symbols of
>> modules also.
>
> maybe a silly question.. but why does it matter? Eg what tool uses this
> info?

Maybe he's creating a tool. Anyway /proc/kallsyms will have all
the symbols and their offsets of the currently running kernel.
It's a good way to find offsets of items not currently exported.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
