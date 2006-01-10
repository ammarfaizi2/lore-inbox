Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWAJHUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWAJHUI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWAJHUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:20:08 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:5715 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750974AbWAJHUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:20:07 -0500
Message-Id: <20060110070945.912712000.dtor_core@ameritech.net>
Date: Tue, 10 Jan 2006 02:09:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] Tiny input update for 2.6.15
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please consider pulling from:

        rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/
or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git/

Changelog:
    Input: ibmasm - fix input initialization error path
    Input: remove obsolete maple input drivers (Paul Mundt)
    Input: prepare for f_ops constness (Arjan van de Ven)
    Input: wistron - do not crash if BIOS does not support interface (Miloslav Trmac)
    Input: grip_mp - kill commented out code

Diffstat:
 drivers/input/input.c             |    2 
 drivers/input/joystick/grip_mp.c  |    9 ---
 drivers/input/keyboard/Kconfig    |   10 ---
 drivers/input/keyboard/Makefile   |    1 
 drivers/input/misc/wistron_btns.c |    6 +-
 drivers/input/mouse/Kconfig       |   10 ---
 drivers/input/mouse/Makefile      |    1 
 drivers/misc/ibmasm/remote.c      |    1 
 drivers/input/mouse/maplemouse.c  |  101 ------------------------------------
 9 files changed, 5 insertions(+), 136 deletions(-)

--
Dmitry

