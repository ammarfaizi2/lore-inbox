Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759019AbWK3E0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759019AbWK3E0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759025AbWK3E0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:26:19 -0500
Received: from www.swissdisk.com ([216.66.254.197]:22195 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1759011AbWK3E0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:26:18 -0500
From: Ben Collins <bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: Ubuntu patch sync for 2.6.20
Reply-To: Ben Collins <bcollins@ubuntu.com>
Date: Wed, 29 Nov 2006 23:26:03 -0500
Message-Id: <11648607732108-git-send-email-bcollins@ubuntu.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11648607683157-git-send-email-bcollins@ubuntu.com>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a set of patches from the Ubuntu tree that seemed suitable for
upstream sync.

[PATCH 1/4] [x86] Add command line option to enable/disable hyper-threading.

[PATCH 2/4] [APIC] Allow disabling of UP APIC/IO-APIC by default, with command line option to turn it on.

[PATCH 3/4] [ATM] Add CPPFLAGS to byteorder.h check.

[PATCH 4/4] [HVCS] Select HVC_CONSOLE if HVCS is enabled.


 arch/i386/Kconfig                   |   13 +++++++++++++
 Documentation/kernel-parameters.txt |    3 +++
 arch/i386/Kconfig                   |    5 +++++
 arch/i386/kernel/apic.c             |   13 +++++++++++--
 arch/i386/kernel/cpu/common.c       |   30 +++++++++++++++++++++++++++++-
 arch/i386/kernel/io_apic.c          |   10 +++++++++-
 drivers/atm/Makefile                |    3 +--
 drivers/char/Kconfig                |    2 +-
 include/asm-i386/apic.h             |    6 ++++++
 include/asm-i386/io_apic.h          |    6 +++++-
 10 files changed, 83 insertions(+), 8 deletions(-)

