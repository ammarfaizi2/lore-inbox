Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWCVXq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWCVXq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWCVXq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:46:59 -0500
Received: from [63.81.120.158] ([63.81.120.158]:31281 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S964830AbWCVXq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:46:58 -0500
Date: Wed, 22 Mar 2006 15:51:16 -0800
From: Todd Poynor <tpoynor@mvista.com>
To: linux-kernel@vger.kernel.org
Subject: include/linux/clk.h is betraying its ARM origins
Message-ID: <20060322235116.GA22213@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/clk.h is betraying its ARM origins.

Signed-off-by: Todd Poynor <tpoynor@mvista.com>

---
commit 311a7ea4852b75d1ea3028786ae87333acbbe720
tree e9236b1801719c47aebe8bdcfad6573a1bfd1cce
parent 1c2e02750b992703a8a18634e08b04353face243
author Todd Poynor <tpoynor@mvista.com> Wed, 22 Mar 2006 15:08:12 -0800
committer Todd Poynor <tpoynor@mvista.com> Wed, 22 Mar 2006 15:08:12 -0800

 include/linux/clk.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 12848f8..5ca8c6f 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -8,8 +8,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef ASMARM_CLOCK_H
-#define ASMARM_CLOCK_H
+#ifndef __LINUX_CLK_H
+#define __LINUX_CLK_H
 
 struct device;
 
