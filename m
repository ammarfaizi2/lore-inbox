Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272588AbTHPEQd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 00:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272599AbTHPEQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 00:16:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29116 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S272588AbTHPEQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 00:16:30 -0400
Date: Sat, 16 Aug 2003 00:16:30 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH 2.4][TRIVIAL][RESEND]  Remove unused function in
 arch/i386/kernel/time.c
To: davej <davej@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <3F3DB01E.40205@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_VZBTe9b8P/Nw6AOxX9SKUw)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_VZBTe9b8P/Nw6AOxX9SKUw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Dave,

   the attached patch fixes a warning about an unused function if 
CONFIG_X86_SUMMIT is not defined.

   The patch applies to 2.4.22-rc1-ac1.

Stephane Ouellette


--Boundary_(ID_VZBTe9b8P/Nw6AOxX9SKUw)
Content-type: text/plain; name=time.c-2.4.22-rc1-ac1.diff; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=time.c-2.4.22-rc1-ac1.diff

--- linux-2.4.22-rc1-ac1-orig/arch/i386/kernel/time.c	Fri Aug  8 22:34:38 2003
+++ linux-2.4.22-rc1-ac1-fixed/arch/i386/kernel/time.c	Sat Aug  9 10:39:57 2003
@@ -431,7 +431,6 @@
 
 const int use_cyclone = 0;
 static void mark_timeoffset_cyclone(void) {}
-static unsigned long do_gettimeoffset_cyclone(void) {return 0;}
 static void init_cyclone_clock(void) {}
 void __cyclone_delay(unsigned long loops) {}
 #endif /* CONFIG_X86_SUMMIT */

--Boundary_(ID_VZBTe9b8P/Nw6AOxX9SKUw)--
