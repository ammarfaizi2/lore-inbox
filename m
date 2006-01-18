Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWARUjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWARUjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWARUjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:39:15 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:32442 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030426AbWARUjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:39:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ADL4/pZGVdDVBMT7lNhx35SLBhx2gG2PsrrkIvGNCuM4WCb0p7PwAM15i4RjtYnYPHxd3LgkP69CfjUIkKVoN6GKtAuo3U/lrqE0LvZJg6flBjPuhK33scw8DBEykmQMKT1fVh5RU3gbtI320N9eBj/+BxZQOKEvKlsxtFP3NUc=
Date: Wed, 18 Jan 2006 23:56:37 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: fix warnings about NR_IRQS being not defined
Message-ID: <20060118205637.GB12771@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-arm26/hardirq.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

--- a/include/asm-arm26/hardirq.h
+++ b/include/asm-arm26/hardirq.h
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/cache.h>
 #include <linux/threads.h>
+#include <asm/irq.h>
 
 typedef struct {
 	unsigned int __softirq_pending;

