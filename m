Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270324AbUJTCke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270324AbUJTCke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270310AbUJTCjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 22:39:00 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:36299 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270280AbUJTCit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:38:49 -0400
Date: Tue, 19 Oct 2004 19:38:29 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>
Subject: [PATCH] UML: add some #includes so we get the correct prototypes
Message-ID: <20041020023829.GG8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add some #includes so we get the correct prototypes

Signed-off-by: cw@f00f.org

diff -Nru a/arch/um/kernel/main.c b/arch/um/kernel/main.c
--- a/arch/um/kernel/main.c	2004-10-19 17:47:53 -07:00
+++ b/arch/um/kernel/main.c	2004-10-19 17:47:53 -07:00
@@ -22,6 +22,8 @@
 #include "mode.h"
 #include "choose-mode.h"
 #include "uml-config.h"
+#include "irq_user.h"
+#include "time_user.h"
 
 /* Set in set_stklim, which is called from main and __wrap_malloc.
  * __wrap_malloc only calls it if main hasn't started.
