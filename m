Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267406AbTACFb5>; Fri, 3 Jan 2003 00:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267407AbTACFb5>; Fri, 3 Jan 2003 00:31:57 -0500
Received: from are.twiddle.net ([64.81.246.98]:49540 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267406AbTACFb4>;
	Fri, 3 Jan 2003 00:31:56 -0500
Date: Thu, 2 Jan 2003 21:39:09 -0800
From: Richard Henderson <rth@twiddle.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] alpha update
Message-ID: <20030102213909.A26815@twiddle.net>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 

	bk://are.twiddle.net/axp-2.5


r~


 arch/alpha/Kconfig              |   13 ++-
 arch/alpha/Makefile             |   96 ++++++++++++-----------------
 arch/alpha/boot/Makefile        |  131 ++++++++++++++++------------------------
 arch/alpha/kernel/Makefile      |  124 ++++++++++++++++++-------------------
 arch/alpha/kernel/alpha_ksyms.c |    2 
 arch/alpha/kernel/irq_i8259.c   |    4 -
 arch/alpha/kernel/sys_alcor.c   |    8 --
 arch/alpha/lib/Makefile         |   71 ++++++++++-----------
 arch/alpha/math-emu/Makefile    |    2 
 include/asm-alpha/irq.h         |    1 
 10 files changed, 202 insertions, 250 deletions

through these ChangeSets:

<rth@are.twiddle.net> (03/01/02 1.976)
   [ALPHA] Makefile cleanup from Sam Ravnborg <sam@ravnborg.org>.

<rth@are.twiddle.net> (03/01/02 1.975)
   [ALPHA] Distribute the irq and extra device init routines in
   arch/alpha/kernel/ to the config options that need them.  Fix
   a few build problems for XLT and RX164.

<rth@are.twiddle.net> (02/12/27 1.954.6.1)
   [ALPHA] Export scr_memcpyw for modular fbcon.

