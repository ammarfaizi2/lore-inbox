Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268020AbTBWDgt>; Sat, 22 Feb 2003 22:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268021AbTBWDgt>; Sat, 22 Feb 2003 22:36:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:47039 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268020AbTBWDgs>;
	Sat, 22 Feb 2003 22:36:48 -0500
Message-ID: <34369.4.64.238.61.1045972018.squirrel@www.osdl.org>
Date: Sat, 22 Feb 2003 19:46:58 -0800 (PST)
Subject: 2.5.62 ide/pci/piix with CONFIG_PROC_FS=n
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I haven't seen this reported, but maybe I just missed it.

drivers/ide/pci/piix.c: In function `piix_config_drive_for_dma':
drivers/ide/pci/piix.c:530: `no_piix_dma' undeclared (first use in this function)
drivers/ide/pci/piix.c:530: (Each undeclared identifier is reported only once
drivers/ide/pci/piix.c:530: for each function it appears in.)
drivers/ide/pci/piix.c: In function `piix_check_450nx':
drivers/ide/pci/piix.c:770: `no_piix_dma' undeclared (first use in this function)

~Randy



