Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWJCMvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWJCMvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWJCMvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:51:46 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:32531 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932096AbWJCMvp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:51:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 03 Oct 2006 12:51:41.0643 (UTC) FILETIME=[AC7089B0:01C6E6EA]
Content-class: urn:content-classes:message
Subject: Re: error to be returned while suspended
Date: Tue, 3 Oct 2006 08:51:36 -0400
Message-ID: <Pine.LNX.4.61.0610030846040.21211@chaos.analogic.com>
In-Reply-To: <200610031323.00547.oliver@neukum.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: error to be returned while suspended
thread-index: Acbm6qyNV/DrBjZpRcmVETpmMJJK0A==
References: <200610031323.00547.oliver@neukum.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Oliver Neukum" <oliver@neukum.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Oct 2006, Oliver Neukum wrote:

> Hi,
>
> which error should a character device return if a read/write cannot be
> serviced because the device is suspended? Shouldn't there be an error
> code specific to that?
>
> 	Regards
> 		Oliver

The de-facto error codes were created long before one could "suspend"
a device, so there isn't a ESUSP code. However, I suggest EIO or EBUSY
unless you want to define an ESUSP and get it accepted by the POSIX
committee.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
