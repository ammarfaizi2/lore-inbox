Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270365AbTHBVqE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270370AbTHBVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 17:46:04 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:39183 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S270365AbTHBVqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 17:46:02 -0400
From: "Willem Bison" <wbison@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Problem installing Promise SATA150 TX2plus driver
Date: Sat, 2 Aug 2003 23:47:03 +0200
Message-ID: <EJEOIHAPIIOEIHNANNCEKENFKJAA.wbison@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to 'insmod' the Promise SATA150 TX2plus driver mentioned
in this message:
http://www.van-dijk.net/linuxkernel/200330/1084.html.gz
I get these errors:
/lib/modules/2.4.20-8smp/kernel/drivers/scsi/pdc-ultra.o: unresolved symbol
scsi_unregister_module
and ...scsi_register, ...scsi_register_module, ...scsi_unregister

The driver was built from source according to the instructions,
*directly* after a fresh install (with kernel headers) of RedHat 9.
(install RH, reboot, wget driver, make -C cam, make, cp, insmod)

The box is a dual Xeon 2.4
The primary HD is a Maxtor 6Y160PO. The secondary, for which i need
the driver, is a WDC Raptor WD360GD SATA. The controler is a Promise
SATA150 TX2plus.

What do I need to do to fix the errors and install the driver ?


