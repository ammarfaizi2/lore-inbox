Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRDXVk5>; Tue, 24 Apr 2001 17:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRDXVkq>; Tue, 24 Apr 2001 17:40:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61454 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131233AbRDXVkc>; Tue, 24 Apr 2001 17:40:32 -0400
Subject: Re: BUG: USB/Reboot
To: swarm@warpcore.provalue.net (Collectively Unconscious)
Date: Tue, 24 Apr 2001 22:41:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10104241447250.26265-100000@warpcore.provalue.net> from "Collectively Unconscious" at Apr 24, 2001 02:49:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14sAZB-00030T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If USB is disabled on a server works MB reboots hang in 2.2.x

In almost all cases a hang after Linux reboots the system and it not coming
back to the BIOS is a BIOS bug.

You can confirm this by asking the kernel to do a real bios reboot with
the reboot= option
