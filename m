Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbTJTD5c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 23:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTJTD5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 23:57:32 -0400
Received: from fmr02.intel.com ([192.55.52.25]:4005 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262384AbTJTD5b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 23:57:31 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.0-test8 compilation issue
Date: Sun, 19 Oct 2003 23:57:26 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC87B8@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.0-test8 compilation issue
Thread-Index: AcOVbLL2MQ/ov8fzRSKU39+9g3YpywBUFdPA
From: "Brown, Len" <len.brown@intel.com>
To: "Aviram Jenik" <aviram@beyondsecurity.com>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Oct 2003 03:57:28.0063 (UTC) FILETIME=[474C20F0:01C396BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/built-in.o(.init.text+0x8cc): In function `acpi_bus_init':
> : undefined reference to `eisa_set_level_irq'
> make: *** [.tmp_vmlinux1] Error 1

If adding CONFIG_PCI isn't a viable workaround for you let me know,
and I'll send you the fix I've got staged.

Thanks,
-Len
