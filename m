Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbUKIWbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbUKIWbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUKIWbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:31:38 -0500
Received: from smtp09.auna.com ([62.81.186.19]:44749 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261721AbUKIWbg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:31:36 -0500
Date: Tue, 09 Nov 2004 22:31:21 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: SATA loosing interrupts
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1100039481l.6523l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Apart from this, 2.6.9-mm1 is fairly stable (Congrats!), I use it as
samba server and is working fine. But sometimes I get this, and the
box gets unresponsive:

Nov  6 04:05:54 nada kernel: ata5: command timeout
Nov  6 04:06:19 nada kernel: hde: dma_timer_expiry: dma status == 0x24
Nov  6 04:06:29 nada kernel: hde: DMA interrupt recovery
Nov  6 04:06:29 nada kernel: hde: lost interrupt

Any ata5 is a SATA channel on the second of two Promise cards.

Any ideas ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #10


