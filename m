Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263021AbSJBJmV>; Wed, 2 Oct 2002 05:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263022AbSJBJmV>; Wed, 2 Oct 2002 05:42:21 -0400
Received: from [212.3.242.3] ([212.3.242.3]:24817 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S263021AbSJBJmU>;
	Wed, 2 Oct 2002 05:42:20 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40: neofb: danger danger - Oopsen imminent
Date: Wed, 2 Oct 2002 11:47:39 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210021147.39338.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use the neofb on my laptop, using the following audio/graphics chip:

01:00.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] 
(rev 12) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 0088
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at f9000000 (32-bit, prefetchable) [size=16M]
        Memory at fdc00000 (32-bit, non-prefetchable) [size=4M]
        Memory at fdb00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 1

When I shut down my system, it is the last message I get. It happens after 
everything has been unmounted. 

After this message the system is locked solid.

DK
-- 
Fudd's First Law of Opposition:
	Push something hard enough and it will fall over.

