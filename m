Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTHTQ7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbTHTQ7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:59:06 -0400
Received: from rivmkt61.wintek.com ([206.230.0.61]:15267 "EHLO dust")
	by vger.kernel.org with ESMTP id S262076AbTHTQ7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:59:03 -0400
Date: Wed, 20 Aug 2003 12:02:22 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: linux-kernel@vger.kernel.org
Subject: Build Broken for 2.6.0-test3-bk8
Message-ID: <Pine.LNX.4.56.0308201201280.4960@dust>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to compile results in this:

arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:548: `skip_ioapic_setup' undeclared (first use in 
this function)
arch/i386/kernel/setup.c:548: (Each undeclared identifier is reported only 
once
arch/i386/kernel/setup.c:548: for each function it appears in.)
make[1]: *** [arch/i386/kernel/setup.o] Error 1
make: *** [arch/i386/kernel] Error 2

regardless of whether APIC support is enabled.

-- 
Alex Goddard
agoddard@purdue.edu
