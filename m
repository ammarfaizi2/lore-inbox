Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSDIQTy>; Tue, 9 Apr 2002 12:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293276AbSDIQTy>; Tue, 9 Apr 2002 12:19:54 -0400
Received: from air-2.osdl.org ([65.201.151.6]:31500 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S293203AbSDIQTx>;
	Tue, 9 Apr 2002 12:19:53 -0400
Date: Tue, 9 Apr 2002 09:17:08 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.7 and runaway modprobe loop?
Message-ID: <Pine.LNX.4.33L2.0204090912540.22258-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

If I build/boot 2.5.7 with 64 GB support (with or without
high_pte), I get:

Freeing unused kernel memory: 448k freed
INIT: version 2.78 booting
kmod: runaway modprobe loop assumed and stopped
kmod: runaway modprobe loop assumed and stopped
kmod: runaway modprobe loop assumed and stopped
kmod: runaway modprobe loop assumed and stopped
kmod: runaway modprobe loop assumed and stopped

If I build/boot it with 4 GB support, it boots fine.

Fixes, suggestion?

This is a 16 GB 8-proc machine (IBM SMP).

Thanks,
-- 
~Randy

