Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUKYIRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUKYIRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 03:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUKYIRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 03:17:35 -0500
Received: from ems.hclinsys.com ([203.90.70.242]:16649 "EHLO ems.hclinsys.com")
	by vger.kernel.org with ESMTP id S263015AbUKYIRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 03:17:33 -0500
Subject: Meaning of HWIF_PROBE_CLASSIC_METHOD
From: Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kernel Newbie <kernelnewbies@nl.linux.org>
Content-Type: text/plain
Message-Id: <1101370757.3795.33.camel@myLinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 25 Nov 2004 13:49:17 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What does this variable stand for? I saw that it was used in
....../drivers/ide/ide-probe.c
There if that macro is defined, probe_hwif() and hwif_init() are called
seperately
and if it is not defined a single function call to probe_hwif_init()
goes.

So that does this HWIF_PROBE_CLASSIC_METHOD stand for? I saw a comment
saying "Probe for drives in the usual way.. CMOS/BIOS, then poke at
ports", what does that imply?

-- 
Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>

