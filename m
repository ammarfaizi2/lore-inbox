Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132595AbRDOIXi>; Sun, 15 Apr 2001 04:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132604AbRDOIX2>; Sun, 15 Apr 2001 04:23:28 -0400
Received: from null.pharm.uic.edu ([128.248.76.23]:4622 "EHLO null.cc.uic.edu")
	by vger.kernel.org with ESMTP id <S132595AbRDOIXP>;
	Sun, 15 Apr 2001 04:23:15 -0400
Date: Sun, 15 Apr 2001 03:23:15 -0500 (CDT)
From: Swivel <swivel@null.pharm.uic.edu>
To: <linux-kernel@vger.kernel.org>
Subject: small bug/oversight found in 2.4.3
Message-ID: <Pine.LNX.4.33.0104150318460.32474-100000@null.cc.uic.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/char.c, line 247
create_proc_read_entry() is called regardless of the definition of
CONFIG_PROC_FS, simply wrap call with #ifdef CONFIG_PROC_FS and #endif.

Cheers,
Vito Caputo


