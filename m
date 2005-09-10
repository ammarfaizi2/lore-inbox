Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVIJMCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVIJMCx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVIJMCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:02:53 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:39318 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750764AbVIJMCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:02:53 -0400
Date: Sat, 10 Sep 2005 14:02:52 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13: kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
Message-ID: <20050910120252.GA31522@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while booting:
Sep 10 13:55:37 iapetus kernel: [drm] Initialized drm 1.0.0 20040925
Sep 10 13:55:37 iapetus kernel: [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 PRO]

Starting Xorg:
Sep 10 13:56:14 iapetus kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
Sep 10 13:56:14 iapetus kernel: [drm:drm_unlock] *ERROR* Process 2170 using kernel context 0

lspci -v|grep radeon stuff:
01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 0054
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at e000 [size=256]
        Memory at fbe00000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at f8000000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
        Capabilities: [50] Power Management version 2


-- 
Frank
