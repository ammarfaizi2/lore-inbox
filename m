Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423008AbWBAXDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423008AbWBAXDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423009AbWBAXDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:03:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3229 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423008AbWBAXDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:03:02 -0500
Date: Wed, 1 Feb 2006 18:02:55 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: missing license tag in intermodule.
Message-ID: <20060201230254.GA3413@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may suck something awful, but it shouldn't taint the kernel.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/kernel/intermodule.c~	2006-02-01 18:01:39.000000000 -0500
+++ linux-2.6.15.noarch/kernel/intermodule.c	2006-02-01 18:01:47.000000000 -0500
@@ -179,3 +179,6 @@ EXPORT_SYMBOL(inter_module_register);
 EXPORT_SYMBOL(inter_module_unregister);
 EXPORT_SYMBOL(inter_module_get_request);
 EXPORT_SYMBOL(inter_module_put);
+
+MODULE_LICENSE("GPL");
+
