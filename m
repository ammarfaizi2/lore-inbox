Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317435AbSGIWCm>; Tue, 9 Jul 2002 18:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317436AbSGIWCl>; Tue, 9 Jul 2002 18:02:41 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:13759 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317435AbSGIWCk>; Tue, 9 Jul 2002 18:02:40 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.25 CONFIG_X86_UP_IOAPIC breaks keyboard
Date: Wed, 10 Jul 2002 02:04:55 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207100204.55749.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After upgrading from 2.5.24 to 2.5.25 (actually bk changeset level
1.628 + ide patches 1.633 from linux-ide.bkbits.net), my keyboard
and mouse stopped working.
Switching off CONFIG_X86_UP_IOAPIC made it work again.

The machine is an IBM thinkpad A30p, which actually has an
IO-APIC as far as I can tell from the old boot logs.

	Arnd <><
