Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbTLKPri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbTLKPri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:47:38 -0500
Received: from bay7-dav3.bay7.hotmail.com ([64.4.10.107]:12805 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265127AbTLKPrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:47:37 -0500
X-Originating-IP: [24.61.138.136]
X-Originating-Email: [jason_kingsland@hotmail.com]
From: "Jason Kingsland" <Jason_Kingsland@hotmail.com>
To: "Peter Chubb" <peter@chubb.wattle.id.au>,
       "Hannu Savolainen" <hannu@opensound.com>
Cc: <linux-kernel@vger.kernel.org>
References: <16343.60461.218583.753101@wombat.chubb.wattle.id.au>
Subject: Re: Driver API (was Re: Linux GPL and binary module exception clause?)
Date: Thu, 11 Dec 2003 10:47:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <BAY7-DAV3DOurk9RY0D00008c86@hotmail.com>
X-OriginalArrivalTime: 11 Dec 2003 15:47:36.0290 (UTC) FILETIME=[19429C20:01C3BFFE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannu Savolainen writes:
> Even better would be a proper device driver ABI for "loosely
> integrated" device drivers.

Peter Chubb writes:

> One of the things we're working on here is an ABI to allow device
> drivers to live in user space, by enabling access to interrupts and
> PCI DMA.

This is already available via a commercial product.

It's a proprietary licensed Linux binary loadable module (hmm...) that
exports the kernel services to user space in an abstract, OS and CPU
agnostic manner. The API is consistent for Win32, Linux, Solaris, VxWorks
and variants.

I've used it previously in a cross-platform commercial application which had
to run on Linux and Win32 and required hardware access, it works well. The
driver is provided as object code which you have to link against the kernel
headers to get access to the appropriate Linux ABI for the target release.

I believe the later versions include support for USB and HotSwap of PCI
busses (for things like CompactPCI) - look at the Kerneldriver and Windriver
products on the following page:

http://www.jungo.com/products.html#driver_tools

ps. Another dubious case of GPL boundaries perhaps - but I'm not going to
restart that thread !
