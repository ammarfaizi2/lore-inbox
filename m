Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285593AbSAVPTZ>; Tue, 22 Jan 2002 10:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSAVPTQ>; Tue, 22 Jan 2002 10:19:16 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:56503 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S285593AbSAVPTC>; Tue, 22 Jan 2002 10:19:02 -0500
Date: Tue, 22 Jan 2002 15:19:51 +0000
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, bjornw@axis.com
Subject: cris patches in 2.5.3-pre3.
Message-ID: <20020122151951.A16157@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, bjornw@axis.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the cris patches in pre3 seem to be going backwards.
Is this intentional? Or just CVS weirdness ?

diff -u --recursive --new-file v2.5.2/linux/arch/cris/Makefile linux/arch/cris/M
--- v2.5.2/linux/arch/cris/Makefile Mon Oct  8 11:43:54 2001
+++ linux/arch/cris/Makefile    Mon Jan 21 16:00:39 2002
@@ -1,4 +1,4 @@
-# $Id: Makefile,v 1.22 2001/10/01 14:42:38 bjornw Exp $
+# $Id: Makefile,v 1.3 2002/01/21 15:21:23 bjornw Exp $
 # cris/Makefile
 #


diff -u --recursive --new-file v2.5.2/linux/arch/cris/boot/rescue/head.S linux/a
--- v2.5.2/linux/arch/cris/boot/rescue/head.S   Mon Oct  8 11:43:54 2001
+++ linux/arch/cris/boot/rescue/head.S  Mon Jan 21 16:00:39 2002
@@ -1,4 +1,4 @@
-/* $Id: head.S,v 1.8 2001/10/03 17:15:15 bjornw Exp $
+/* $Id: head.S,v 1.2 2001/12/18 13:35:12 bjornw Exp $
  * 
  * 

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
