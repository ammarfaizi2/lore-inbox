Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUEBO7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUEBO7t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 10:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUEBO7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 10:59:49 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:49122 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S262175AbUEBO7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 10:59:47 -0400
Date: Sun, 2 May 2004 16:59:43 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: drm:r128_cce_start messages in log
Message-ID: <20040502145943.GL26906@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Recently, I'm getting these drm entries in the log. This is on a
2.6.6-rc3-mm1 box with xfree86-common 4.3.0.dfsg.1-1:

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128
PF/PRO AGP 4x TMDS (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage Fury Pro/Xpert 2000 Pro
        Flags: bus master, VGA palette snoop, stepping, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at e4000000 (32-bit, prefetchable)
        I/O ports at c000 [size=256]
        Memory at e9000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 2

What do they mean?

May  2 15:49:40 shawarma kernel: *ERROR* r128_cce_reset called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_start] *ERROR* r128_cce_start called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_idle] *ERROR* r128_cce_idle called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_reset] *ERROR* r128_cce_reset called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_start] *ERROR* r128_cce_start called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_idle] *ERROR* r128_cce_idle called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_reset] *ERROR* r128_cce_reset called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_start] *ERROR* r128_cce_start called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_idle] *ERROR* r128_cce_idle called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_reset] *ERROR* r128_cce_reset called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_start] *ERROR* r128_cce_start called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_idle] *ERROR* r128_cce_idle called without lock held
May  2 15:49:40 shawarma kernel: [drm:r128_cce_reset] *ERROR* r128_cce_reset called without lock held
... many many entries ...
May  2 15:50:20 shawarma kernel: [drm:r128_cce_reset] *ERROR* r128_cce_reset called without lock held
May  2 15:50:20 shawarma kernel: [drm:r128_cce_start] *ERROR* r128_cce_start called without lock held
May  2 15:50:20 shawarma kernel: [drm:r128_cce_idle] *ERROR* r128_cce_idle called without lock held
May  2 15:50:20 shawarma kernel: [drm:r128_cce_reset] *ERROR* r128_cce_reset called without lock held


-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
