Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVKJODy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVKJODy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVKJODx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:03:53 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:8711 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750908AbVKJODk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:03:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <437347B5.6080201@gmail.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
References: <437347B5.6080201@gmail.com>
X-OriginalArrivalTime: 10 Nov 2005 14:03:38.0211 (UTC) FILETIME=[8C3C4B30:01C5E5FF]
Content-class: urn:content-classes:message
Subject: Re: MOD_INC_USE_COUNT
Date: Thu, 10 Nov 2005 09:03:37 -0500
Message-ID: <Pine.LNX.4.61.0511100859400.18912@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MOD_INC_USE_COUNT
Thread-Index: AcXl/4xi7YvNXy43SBCc289fAOD3yw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Tony" <tony.uestc@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Nov 2005, Tony wrote:

> Hello All,
> Usually, when a net_device->open is called, it will MOD_INC_USE_COUNT on
> success. It is removed since 2.5.x, then should I increase the use
> count? how? thx.

Gone! Don't use INC or DEC_USE_COUNT anymore. The kernel takes
care of that for you. Also, the count shown in `lsmod` no longer
means anything you can use programmaticly.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
