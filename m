Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUFUPPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUFUPPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266261AbUFUPPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:15:19 -0400
Received: from [213.200.103.80] ([213.200.103.80]:62727 "EHLO
	Hommer.netway.org") by vger.kernel.org with ESMTP id S264266AbUFUPPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:15:15 -0400
Message-ID: <01bb01c457a2$8cad42a0$bd01a8c0@oops>
From: "Pablo Ruiz Garcia" <pruiz@netway.org>
To: penguinppc-team@lists.penguinppc.org
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: MPC8272ADS and MPc8260ADS Boards support (kernel 2.6)
Date: Mon, 21 Jun 2004 17:15:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here is attached a patch to support mpc8272 and mpc8260 (ADS) reference boards with kernel 2.6 (2.6.6)

This code is working right now, but with a stupid bugs if you use both serial ports at the same time (it will be fixed in the near
time). KGDB support must be fixed if used within main kernel console. USB (and probably UTOPIA) support is also planed based on
existing mpc860 code.

http://www.netway.org/linux-2.6.6-mpc82xxads.diff

Any problem or working reports will be apreciated.

Att. Pablo

--
Pablo Ruiz Garcia (Pci)
Enterasys ESE/CISSP Certified
Security Consultancy - Tiger Team
Meet just your security needs <pruiz@netway.org>

