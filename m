Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVA0KQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVA0KQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVA0KPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:15:09 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:43268 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262547AbVA0KO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:14:28 -0500
Date: Thu, 27 Jan 2005 10:14:27 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Patch 6/6  default enable randomisation for -mm
Message-ID: <20050127101427.GG9760@infradead.org>
References: <20050127101117.GA9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127101117.GA9760@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For -mm only to increease testing; enable the randomisations by default

Signed-off-by: Arjan van de Ven <arjan@infradead.org>

diff -purN linux-step5/kernel/sysctl.c linux-step6/kernel/sysctl.c
--- linux-step5/kernel/sysctl.c	2005-01-27 10:22:14.000000000 +0100
+++ linux-step6/kernel/sysctl.c	2005-01-27 10:35:31.000000000 +0100
@@ -122,7 +122,7 @@ extern int sysctl_hz_timer;
 extern int acct_parm[];
 #endif
 
-int randomize_va_space = 0;
+int randomize_va_space = 1;
 
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);

