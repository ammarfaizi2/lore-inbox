Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758356AbWK0QbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758356AbWK0QbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758369AbWK0QbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:31:24 -0500
Received: from mail2.keyvoice.com ([12.153.69.53]:22607 "EHLO
	outbound.comdial.com") by vger.kernel.org with ESMTP
	id S1758356AbWK0QbX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:31:23 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: Reserving a fixed physical address page of RAM.
Date: Mon, 27 Nov 2006 11:31:21 -0500
Message-ID: <22170ADB26112F478A4E293FF9D449F44D0EBD@secure.comdial.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reserving a fixed physical address page of RAM.
Thread-Index: AccSQXjO1oZzi3ydRe2bFSA9GW/DVg==
From: "Jon Ringle" <JRingle@vertical.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need to reserve a page of memory at a specific area of RAM that will
be used as a "shared memory" with another processor over PCI. How can I
ensure that the this area of RAM gets reseved so that the Linux's memory
management (kmalloc() and friends) don't use it?

Some things that I've considered are iotable_init() and ioremap().
However, I've seen these used for memory mapped IO devices which are
outside of the RAM memory. Can I use them for reseving RAM too?

I appreciate any advice in this regard.

Thanks,

Jon
