Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUB1POP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 10:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUB1POP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 10:14:15 -0500
Received: from science.horizon.com ([192.35.100.1]:64315 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261866AbUB1PON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 10:14:13 -0500
Date: 28 Feb 2004 15:14:12 -0000
Message-ID: <20040228151412.26800.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc1: DCSSBLK device is offered on x86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The help is remarkably unhelpful "Support for dcss block device".
Google has never heard of "dcssblk" and for "dcss" suggests:

- Digital Consulting and Software Services
- Department of Child Support Services
- Division of Child Support Services
- Dave Culp Speedsailing
- "DeCSS" (for DVDs) misspelled.
- Dougherty County School System
- Distributed Control Systems
- Direct + Club Sales Server
- Distributed Control System Server
  (Hey, it's a sort of device driver - for the X-ray crystallography
  system at the Stanford Linear Accelerator Center.)

... anyway, after a bit of source-tree grepping it turns out to be in
srivers/s30 and stand for "Discontiguous Shared Segment", which
appears to be IBM-ese.

Perhaps drivers/s390/Kconfig could have another "depends on ARCH_S390"
line added?
