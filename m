Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVJ0VJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVJ0VJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVJ0VJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:09:29 -0400
Received: from spirit.analogic.com ([204.178.40.4]:2056 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932258AbVJ0VJ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:09:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1130445194.5416.3.camel@blade>
References: <1130445194.5416.3.camel@blade>
X-OriginalArrivalTime: 27 Oct 2005 21:09:26.0985 (UTC) FILETIME=[B6B55390:01C5DB3A]
Content-class: urn:content-classes:message
Subject: Re: 4GB memory and Intel Dual-Core system
Date: Thu, 27 Oct 2005 17:09:26 -0400
Message-ID: <Pine.LNX.4.61.0510271705470.10406@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 4GB memory and Intel Dual-Core system
Thread-Index: AcXbOrbW/V/GEnFyT2WE26RIDdmiAQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Oct 2005, Marcel Holtmann wrote:

> Hi guys,
>
> I installed 4 x 1 GB DDR2 memory in my Intel Dual-Core 2.80GHz system,
> but it shows me only 3.3 GB of RAM:
>
> Memory: 3339124k/3398656k available (2029k kernel code, 56232k reserved,
> 741k data, 184k init)
>
> The BIOS and dmidecode tells me that I have 4 GB of RAM installed and I
> don't have any idea where to look for details. What information do you
> need to analyze this?
>
> Regards
>
> Marcel

Hmmm. Do you have a screen card? Trick question. It takes address-
space. How about stuff on the PCI bus? That takes address-space
also. If you look at the boot log, you will probably find that
there is a lot of "reserved" address-space. Since RAM needs
to "share" such address-space, any RAM behind the reserved addresses
will not be accessed.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
