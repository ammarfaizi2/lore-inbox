Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTFTSkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTFTSkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:40:35 -0400
Received: from mail0.lsil.com ([147.145.40.20]:19630 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S264266AbTFTSkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:40:33 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E570185F2A3@EXA-ATLANTA.se.lsil.com>
From: "Mukker, Atul" <atulm@lsil.com>
To: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "'alan@redhat.com'" <alan@redhat.com>
Subject: [ANNOUNCE]: megaraid 1.18i driver
Date: Fri, 20 Jun 2003 14:54:23 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

1.18 series of the driver has been upgraded to 1.18i. This driver has fixes
for management applications not working with stock 1.18f driver. Other
changes are: Kernel would panic if 2.00.x megaraid driver is loaded on top
of 1.18h or previous drivers. This was because of a bug in older drivers
which were not reserving the controller's memory region.

This driver also incorporates the important changes made 1.18g and 1.18h
driver for firmware handshake. The driver and the patch for 1.18f driver can
be downloaded at:

ftp://ftp.lsil.com/pub/linux-megaraid/drivers/


Thanks
-Atul Mukker <atulm@lsil.com>
LSI Logic Corporation
