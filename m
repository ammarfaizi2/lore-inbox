Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUCDHUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 02:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUCDHUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 02:20:49 -0500
Received: from math.ut.ee ([193.40.5.125]:6907 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261533AbUCDHUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 02:20:47 -0500
Date: Thu, 4 Mar 2004 09:20:44 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.25 hangs with smartrd+SMP(HT)
Message-ID: <Pine.GSO.4.44.0403040915140.2398-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server with Intel S875WP-1 mainboard (875P chipset). I'm using
2 WD SATA hard disks with ICH5 SATA. The system is running debian
stable.

I compiled a fresh 2.4.25 (SMP) for pristine source (no patches). When I
enable HT from BIOS _and_ start smartd the system hangs hard (no SysRq).
When I disable either HT or do not start smartd, it works. Enabling HT
and just issuing smartctl -a to drives works fine too.

-- 
Meelis Roos (mroos@linux.ee)

