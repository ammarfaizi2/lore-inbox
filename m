Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSLAJ3b>; Sun, 1 Dec 2002 04:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSLAJ3b>; Sun, 1 Dec 2002 04:29:31 -0500
Received: from tmailm1.svr.pol.co.uk ([195.92.193.20]:42260 "EHLO
	tmailm1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261573AbSLAJ3a>; Sun, 1 Dec 2002 04:29:30 -0500
Subject: 2.4.20 DRM/DRI issue with Radeon
From: Andy Jefferson <andy@ajsoft.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Dec 2002 09:36:13 +0000
Message-Id: <1038735373.2617.12.camel@monster.ajsoft.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.4.20 kernel changelog I see comments about having consistent
DRM modules with XFree4.2.0. I have a Radeon Mobility M6 LY in a Dell
laptop and would like to get DRI working. Whenever I use any 2.4.*
(including 2.4.20) kernel I get the following messages in
/var/log/XFree86.0.log, and DRM is not enabled. Is this supposed to be
working in 2.4.20 ? I am using a Mandrake 8.2 system (except for the
kernel).


(II) RADEON(0): [drm] loaded kernel module for "radeon" driver
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:1:0:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xd1bb1000
(II) RADEON(0): [drm] mapped SAREA 0xd1bb1000 to 0x40026000
(II) RADEON(0): [drm] framebuffer handle = 0xe0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(EE) RADEON(0): [dri] RADEONDRIScreenInit failed because of a version
mismatch.
[dri] radeon.o kernel module version is 1.1.1 but version 1.2.x is
needed.
[dri] see http://gatos.sf.net/ for an updated module
[dri] Disabling DRI.
(EE) RADEON(0): [drm] failed to remove DRM signal handler
(II) RADEON(0): [drm] removed 1 reserved context for kernel

Thx
-- 
Andy
