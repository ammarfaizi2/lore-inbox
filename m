Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVJCQqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVJCQqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVJCQqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:46:32 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:41996 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932481AbVJCQqa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:46:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051003153527.53128.qmail@web32909.mail.mud.yahoo.com>
References: <20051003153527.53128.qmail@web32909.mail.mud.yahoo.com>
X-OriginalArrivalTime: 03 Oct 2005 16:46:27.0639 (UTC) FILETIME=[FF923470:01C5C839]
Content-class: urn:content-classes:message
Subject: Re: ppc boot entry point
Date: Mon, 3 Oct 2005 12:46:26 -0400
Message-ID: <Pine.LNX.4.61.0510031240190.22248@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ppc boot entry point
Thread-Index: AcXIOf+zuMqQ3xfFS1G9Nj8rl1PnZw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Dave B. Sharp" <daveb_sharp@yahoo.ca>
Cc: <kernelnewbies@nl.linux.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Oct 2005, Dave B. Sharp wrote:

> Hey there,
> Can anyone tell me how to find te entry point (i.e.
> address) into the kernel, when control is passed from
> the boot loader?

Look at System.map. phys_startup_32 and startup_32. The
former is the physical (bus) address where it must be
loaded, the latter is the virtual address after it
starts.

> Where are the arguements such as the boot parameters.
> I am compiling for a generic ppc kernel at this point.
>  Cheers
>   Dave Sharp
>

Look at address, boot_params, also shown in System.map. That's
where they end up being relocated.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
