Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130396AbRBPPZe>; Fri, 16 Feb 2001 10:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130416AbRBPPZY>; Fri, 16 Feb 2001 10:25:24 -0500
Received: from [24.221.152.185] ([24.221.152.185]:26606 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S130396AbRBPPZO>; Fri, 16 Feb 2001 10:25:14 -0500
Date: Fri, 16 Feb 2001 08:19:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_MODVERSIONS and same named files
Message-ID: <20010216081928.A2209@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all.  The modversions code has a slight problem with files of the same
name, but in different directories.  eg: drivers/a/foo.c exports FOO, and
drivers/b/foo.c exports BAR, include/linux/modules/foo.ver will only have the
information about drivers/b/foo.c.  Anyone got an idea on how to fix this?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
