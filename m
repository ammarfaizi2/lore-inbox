Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbWASCyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbWASCyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 21:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWASCyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 21:54:11 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:49575 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030510AbWASCyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 21:54:09 -0500
Date: Wed, 18 Jan 2006 21:48:35 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.16-rc1-mm1] i386: make stack backtrace default to
  two columns
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601182151_MC3-1-B629-3B4A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make stack backtrace columns default to 2 so this gets
some testing.

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc1-mm1.orig/arch/i386/Kconfig.debug
+++ 2.6.16-rc1-mm1/arch/i386/Kconfig.debug
@@ -34,7 +34,7 @@ config DEBUG_STACK_USAGE
 config STACK_BACKTRACE_COLS
 	int "Stack backtraces per line" if DEBUG_KERNEL
 	range 1 3
-	default 1
+	default 2
 	help
 	  Selects how many stack backtrace entries per line to display.
