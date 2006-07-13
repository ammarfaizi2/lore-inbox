Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWGMEoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWGMEoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 00:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWGMEoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 00:44:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30366 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932499AbWGMEoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 00:44:22 -0400
Date: Thu, 13 Jul 2006 00:44:15 -0400
From: Dave Jones <davej@redhat.com>
To: sam@ravnborg.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: typo in modpost
Message-ID: <20060713044415.GA15954@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, sam@ravnborg.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by a Fedora user when they tried to build some out of tree module..

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/scripts/Makefile.modpost~	2006-07-13 00:39:18.000000000 -0400
+++ linux-2.6/scripts/Makefile.modpost	2006-07-13 00:39:22.000000000 -0400
@@ -40,7 +40,7 @@ include scripts/Kbuild.include
 include scripts/Makefile.lib
 
 kernelsymfile := $(objtree)/Module.symvers
-modulesymfile := $(KBUILD_EXTMOD)/Modules.symvers
+modulesymfile := $(KBUILD_EXTMOD)/Module.symvers
 
 # Step 1), find all modules listed in $(MODVERDIR)/
 __modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))

-- 
http://www.codemonkey.org.uk
