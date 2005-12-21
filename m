Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVLULKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVLULKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVLULKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:10:23 -0500
Received: from tag.witbe.net ([81.88.96.48]:28292 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S932358AbVLULKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:10:22 -0500
Message-Id: <200512211110.jBLBALD24852@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [Linux 2.4.32] SATA ICH5/PIIX and Combined mode
Date: Wed, 21 Dec 2005 12:10:22 +0100
Organization: AS2917.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcYGHyK/I19tdbztTFiIxwUrfAO5RA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a machine with two SATA HDD, and one PATA CDRom.
Bios is configured for combined mode, and installing a RedHat ES3
(Kernel 2.4.21-ELsmp) is fine, the two HDD are up, the installation
is fine and the CDRom is working.

Then, upgrading to a vanilla 2.4.32, the ata_piix.c file contains
a "combined mode not supported" and booting the machine hangs, as
no VFS are up for root device.

Of course, I can disable the Combined setup in the BIOS, then I have
my two HDD, but no CDRom... 

What is the "trick" to have a 2.4.32 be able to do what a 2.4.21 was
doing ?

Thanks in advance,
Regards,
Paul

Paul Rolland, rol@as2917.net

