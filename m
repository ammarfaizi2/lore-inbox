Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262057AbRETPtX>; Sun, 20 May 2001 11:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262058AbRETPtN>; Sun, 20 May 2001 11:49:13 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:47374 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262057AbRETPsx>;
	Sun, 20 May 2001 11:48:53 -0400
Date: Sun, 20 May 2001 11:47:38 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Patch for sbus makefile bug
Message-ID: <20010520114738.A3666@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somebody failed to track a module name change.

--- drivers/sbus/char/Makefile	2001/05/20 15:33:48	1.1
+++ drivers/sbus/char/Makefile	2001/05/20 15:34:03
@@ -31,7 +31,7 @@
 obj-$(CONFIG_SUN_AURORA)		+= aurora.o
 obj-$(CONFIG_TADPOLE_TS102_UCTRL)	+= uctrl.o
 obj-$(CONFIG_SUN_JSFLASH)		+= jsflash.o
-obj-$(CONFIG_BBC_I2C)			+= bbc.o
+obj-$(CONFIG_BBC_I2C)			+= bbc_i2c.o
 
 include $(TOPDIR)/Rules.make
 
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A man who has nothing which he is willing to fight for, nothing 
which he cares about more than he does about his personal safety, 
is a miserable creature who has no chance of being free, unless made 
and kept so by the exertions of better men than himself. 
	-- John Stuart Mill, writing on the U.S. Civil War in 1862
