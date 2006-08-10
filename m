Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWHJXrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWHJXrt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWHJXrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:47:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10919 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932315AbWHJXrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:47:48 -0400
Date: Thu, 10 Aug 2006 19:47:24 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Remove another config.h
Message-ID: <20060810234724.GA8052@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the asm/ uses of #include <linux/config.h>
this one is the next biggest source of noise.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/include/linux/vmstat.h~	2006-08-10 19:43:49.000000000 -0400
+++ linux-2.6.17.noarch/include/linux/vmstat.h	2006-08-10 19:43:54.000000000 -0400
@@ -3,7 +3,6 @@
 
 #include <linux/types.h>
 #include <linux/percpu.h>
-#include <linux/config.h>
 #include <linux/mmzone.h>
 #include <asm/atomic.h>
 
-- 
http://www.codemonkey.org.uk
