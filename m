Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWFARYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWFARYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWFARYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:24:45 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:43785 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964934AbWFARYo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:24:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 01 Jun 2006 17:24:41.0285 (UTC) FILETIME=[443E8F50:01C685A0]
Content-class: urn:content-classes:message
Subject: Re: USB devices fail unnecessarily on unpowered hubs
Date: Thu, 1 Jun 2006 13:24:39 -0400
Message-ID: <Pine.LNX.4.61.0606011320590.2085@chaos.analogic.com>
In-Reply-To: <200606011753.38157.oliver@neukum.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: USB devices fail unnecessarily on unpowered hubs
Thread-Index: AcaFoERKTw2RrMw7SR2y2fo2VluDMw==
References: <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org> <Pine.LNX.4.61.0606011104140.1745@chaos.analogic.com> <200606011753.38157.oliver@neukum.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Oliver Neukum" <oliver@neukum.org>
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Andrew Morton" <akpm@osdl.org>,
       "David Liontooth" <liontooth@cogweb.net>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Jun 2006, Oliver Neukum wrote:

> Am Donnerstag, 1. Juni 2006 17:09 schrieb linux-os (Dick Johnson):
>> Many, most, perhaps all such devices don't take more power when they
>> are "enabled". Everything is already running and sucking up maximum
>> current when you plug it in! If the motherboard didn't smoke when
>
> If they do, they are violating the spec. A device in the unconfigured (state 0)
> state must not draw more than 100mA.
>
> 	Regards
> 		Oliver
>

Hmmm, the USB-IF recommends 100 mA per port, not requires.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.73 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
