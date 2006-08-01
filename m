Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161368AbWHALNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161368AbWHALNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWHALGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59100 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932631AbWHALFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:31 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 7/33] elf: Add ELFOSABI_STANDALONE to elf.h
Date: Tue,  1 Aug 2006 05:03:22 -0600
Message-Id: <11544302323001-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/elf.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/elf.h b/include/linux/elf.h
index c5bf043..6fa8d3d 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -338,8 +338,9 @@ #define EV_NONE		0		/* e_version, EI_VER
 #define EV_CURRENT	1
 #define EV_NUM		2
 
-#define ELFOSABI_NONE	0
-#define ELFOSABI_LINUX	3
+#define ELFOSABI_NONE		0
+#define ELFOSABI_LINUX		3
+#define ELFOSABI_STANDALONE	255
 
 #ifndef ELF_OSABI
 #define ELF_OSABI ELFOSABI_NONE
-- 
1.4.2.rc2.g5209e

