Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVKJWOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVKJWOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVKJWOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:14:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52164 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932200AbVKJWOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:14:14 -0500
Date: Thu, 10 Nov 2005 17:14:11 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: saa711x driver doesn't need segment.h
Message-ID: <20051110221411.GA26539@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This breaks compilation on non-x86 architectures,
and isn't even used.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/media/video/saa711x.c~	2005-11-10 15:27:05.000000000 -0500
+++ linux-2.6.14/drivers/media/video/saa711x.c	2005-11-10 15:27:33.000000000 -0500
@@ -36,7 +36,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 #include <asm/uaccess.h>
 #include <linux/videodev.h>
