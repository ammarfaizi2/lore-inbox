Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUBINrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUBINrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:47:52 -0500
Received: from [202.125.86.130] ([202.125.86.130]:44954 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S265221AbUBINrv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:47:51 -0500
Subject: PCI based storage controller driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Mon, 9 Feb 2004 19:11:19 +0530
Content-class: urn:content-classes:message
Message-ID: <1118873EE1755348B4812EA29C55A97212795B@esnmail.esntechnologies.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI based storage controller driver
Thread-Index: AcPvEkqMg1EMgL4KSUC2joVW0fUSSwAAA3zQ
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We are writing a PCI storage controller driver on Linux.

Each of the PCI storage controllers can support up to 5 Memory devices (block). The driver we are developing should support many such PCI controllers with each one of them having 0 to 5 memory devices. The memory devices can be hot pluggable.

Our main concern here is the way we can associate the device structure (our structure) and the PCI structure (pci_dev) to each of the memory devices based on just the minor number.

I would like to know if some open source code exists which closely matches my requirement. We intend to develop it under GPL terms.

Regards,
-Jinu

