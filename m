Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVALTgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVALTgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVALT3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:29:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39605 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261350AbVALT1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:27:47 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Excess whitespace cleanup
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 12 Jan 2005 19:27:43 +0000
Message-ID: <16108.1105558063@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch cleans up some excess whitespace from the FRV entry.S.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-cleanup-2611rc1.diff 
 arch/frv/kernel/entry.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc1/arch/frv/kernel/entry.S linux-2.6.11-rc1-frv/arch/frv/kernel/entry.S
--- /warthog/kernels/linux-2.6.11-rc1/arch/frv/kernel/entry.S	2005-01-12 19:08:31.000000000 +0000
+++ linux-2.6.11-rc1-frv/arch/frv/kernel/entry.S	2005-01-12 19:12:00.125483158 +0000
@@ -1075,7 +1075,7 @@ __entry_work_resched:
 	andicc		gr4,#_TIF_NEED_RESCHED,gr0,icc0
 	bne		icc0,#1,__entry_work_resched
 
- __entry_work_notifysig:
+__entry_work_notifysig:
 	LEDS		0x6410
 	ori.p		gr4,#0,gr8
 	call		do_notify_resume
