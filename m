Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbTANMXX>; Tue, 14 Jan 2003 07:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTANMXX>; Tue, 14 Jan 2003 07:23:23 -0500
Received: from mail-gw2.credit-suisse.com ([198.240.213.28]:31876 "EHLO
	mail-gw2.credit-suisse.com") by vger.kernel.org with ESMTP
	id <S262360AbTANMXX>; Tue, 14 Jan 2003 07:23:23 -0500
Message-ID: <F12E8D9F1EA37D4E9165C8D13ECA6952013672FE@sxchs017.csintra.net>
From: "Capaul Giachen F (KADA 12)" <flurin.capaul@csfs.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [Question] Assinging of IRQ to an ethernet card
Date: Tue, 14 Jan 2003 13:31:46 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain; charset="iso-8859-1"
X-Security: Prun-O-Matic by Gromit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My ethernet card is unfortunately being assigned IRQ 19 instead of IRQ 11. My C and kernel knowledge is virtually inexisten, yet I'd like to try and fix that myself, by  basically telling my kernel that IRQ 11 is the one to take. I had a look at a driver code (8139too.c) and was under the impression that the assignment of the IRQ is done somewhere else. I'm currently looking at irq.c in the arch\i386\pci\ directory. Is that the right place to attempt this, or should I be looking somewhere else? 

Thank you for your help,

-Flurin
