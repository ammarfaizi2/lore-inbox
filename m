Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUGVT13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUGVT13 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUGVT13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:27:29 -0400
Received: from [138.15.108.3] ([138.15.108.3]:51361 "EHLO mailer.nec-labs.com")
	by vger.kernel.org with ESMTP id S261232AbUGVT12 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:27:28 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Compression filter for Loopback device
Date: Thu, 22 Jul 2004 15:27:17 -0400
Message-ID: <951A499AA688EF47A898B45F25BD8EE80126D4D6@mailer.nec-labs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compression filter for Loopback device
Thread-Index: AcRwIeaMA9GTkuQiRSyZOSpILbc+sg==
From: "Lei Yang" <leiyang@nec-labs.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Is there anything like 'losetup' that allows choosing encryption
algorithm for a loopback device that can be used on compression
algorithms? Or in other words, when the data passes through loopback
device to a real storage device, it can be filtered and the filter is
compression instead of encryption; when kernel ask for data in a storage
device that is mounted to a loopback device with compression, it will be
filtered again -- decompressed.

If there is not a ready-to-use method for this, is there any way I can
implement the idea?

TIA! Really appreciate any comments.

Lei
