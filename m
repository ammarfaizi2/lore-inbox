Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVELVVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVELVVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVELVVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:21:33 -0400
Received: from dsl092-010-080.sfo1.dsl.speakeasy.net ([66.92.10.80]:33653 "EHLO
	FILTERGUY.nuvation.com") by vger.kernel.org with ESMTP
	id S262128AbVELVVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:21:19 -0400
Message-ID: <FC3C0DD86B79DF4FA423AF0379A54761029DD0EA@mailguy2.nuvation.com>
From: Joe Istead <jistead@nuvation.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: non-PCI libata
Date: Thu, 12 May 2005 14:20:22 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a question related to an LKML post on April 5, 2005:

http://lkml.org/lkml/2005/4/5/210

Preamble:
I'm developing a low level driver for a non-PCI AHCI controller.  In
particular, I'm using uClinux (2.6.x kernel) on a Nios II processor (Avalon
bus, etc etc).  

It looks like porting "drivers/scsi/ahci.c" to uClinux is the easiest way to
do this.  However, ahci.c depends on libata, and both of these are littered
with PCI-specific calls.

Question:
Is there a non-PCI libata (or, are there plans to make one)?

Thanks,
Joe.
