Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbTJ3UI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 15:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbTJ3UI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 15:08:57 -0500
Received: from smtp1.libero.it ([193.70.192.51]:2980 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S262799AbTJ3UIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 15:08:55 -0500
Date: Thu, 30 Oct 2003 21:10:49 +0100
From: Daniele Pala <dandario@libero.it>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org
Subject: [PPC] Mouse emulate buttons
Message-ID: <20031030201049.GA322@SuperSoul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like there's no reason for mouse buttons emulation to depend on ADB

Daniele




--- linux-2.6.0-test9/arch/ppc/Kconfig	Fri Oct 10 15:28:39 2003
+++ linux-2.6.0-test9_MOD/arch/ppc/Kconfig	Thu Oct 30 17:22:00 2003
@@ -1234,7 +1234,6 @@
 
 config MAC_EMUMOUSEBTN
 	bool "Support for mouse button 2+3 emulation"
-	depends on INPUT_ADBHID
 	help
 	  This provides generic support for emulating the 2nd and 3rd mouse
 	  button with keypresses.  If you say Y here, the emulation is still

