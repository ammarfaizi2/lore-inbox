Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287631AbSCTWAQ>; Wed, 20 Mar 2002 17:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSCTWAG>; Wed, 20 Mar 2002 17:00:06 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:19719 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S312237AbSCTV7u> convert rfc822-to-8bit; Wed, 20 Mar 2002 16:59:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Hooks for random device entropy generation missing incpqarray.c
Date: Wed, 20 Mar 2002 15:59:43 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E106401281374@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hooks for random device entropy generation missing incpqarray.c
thread-index: AcHQWS1JvBcAa8zESjiHbY9N+i4yOQAAQu5g
From: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
To: "Manon Goo" <manon@manon.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Mar 2002 21:59:43.0750 (UTC) FILETIME=[8ACE6260:01C1D05A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I have not tried your patch.  but this is in cpqarray_init() 
> and it is only 
> called when the driver is initilaized.
> How is the entropy-pool further updated ?

It's done in linux/arch/*/kernel/irq.c.
for i386, in handle_IRQ_event() function.

-- steve

