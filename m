Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbUKBNOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbUKBNOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbUKBNKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:10:49 -0500
Received: from [212.209.10.221] ([212.209.10.221]:3029 "EHLO krynn.se.axis.com")
	by vger.kernel.org with ESMTP id S262977AbUKBNFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:05:12 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: [PATCH 8/10] CRIS architecture update - Move drivers
Date: Tue, 2 Nov 2004 14:04:51 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C748C@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01E0_01C4C0E4.EC093780"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01E0_01C4C0E4.EC093780
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is a shell script to move drivers from arch/cris/arch-v10/drivers to
e.g. drivers/net/cris/v10. This must be applied after patch 1-7 and before
patch 9.

Let me know if you prefer this as a big diff instead.

Signed-Off-By: starvik@axis.com

/Mikael

------=_NextPart_000_01E0_01C4C0E4.EC093780
Content-Type: application/octet-stream;
	name="move_cris_269.sh"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="move_cris_269.sh"

#!/bin/sh=0A=
mkdir -p drivers/ide/cris/v10=0A=
mkdir -p drivers/net/cris/v10=0A=
mkdir -p drivers/serial/cris/v10=0A=
mkdir -p drivers/usb/host/cris/v10=0A=
mv arch/cris/arch-v10/drivers/ide.c drivers/ide/cris/v10=0A=
mv arch/cris/arch-v10/drivers/ethernet.c drivers/net/cris/v10=0A=
mv arch/cris/arch-v10/drivers/serial.* drivers/serial/cris/v10=0A=
mv arch/cris/arch-v10/drivers/usb-host.* drivers/usb/host/cris/v10=0A=
=0A=
=0A=

------=_NextPart_000_01E0_01C4C0E4.EC093780--

