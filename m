Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266232AbUBLAlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 19:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUBLAlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 19:41:03 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:19979 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266232AbUBLAlB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 19:41:01 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] cpqarray update for kernel 2.6.2 [0/5]
Date: Wed, 11 Feb 2004 18:40:46 -0600
Message-ID: <CBD6B29E2DA6954FABAC137771769D6504E1597B@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpqarray update for kernel 2.6.2 [0/5]
Thread-Index: AcPl97MDYCr9uBZ6RfOTYAJ7P0onNQLB+cCA
From: "Wiran, Francis" <francis.wiran@hp.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
X-OriginalArrivalTime: 12 Feb 2004 00:40:47.0740 (UTC) FILETIME=[DB42FBC0:01C3F100]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some updates for cpqarray. It seems cpqarray in kernel 2.6.1 corresponds
to the one in 2.4.18, so here's the updates from 2.4.19 onward

Summary of updates:
- Modify contact info and version number
- Fix for segmentation fault when rmmod is called.
- New variables io_mem_addr and io_mem_length to replace ioaddr.
- Use PCI APIs (pci_register_driver, pci_unregister_driver, etc).
Support for EISA cards is also included.
- Check rc of pci_register_driver()

To do:
- import 2.4.x updates for ioctl.



Thanks
-francis-

