Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967579AbWK2TTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967579AbWK2TTB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967582AbWK2TTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:19:01 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:23050 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S967579AbWK2TTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:19:00 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mips dbg_io stray brackets fix
Date: Wed, 29 Nov 2006 20:18:24 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611292018.24238.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This macro is not used. Better have it fixed than broken anyway.

This patch adds stray brackets.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 dbg_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/arch/mips/pmc-sierra/yosemite/dbg_io.c	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/arch/mips/pmc-sierra/yosemite/dbg_io.c	2006-11-29 14:43:58.000000000 +0100
@@ -93,7 +93,7 @@
  * Functions to READ and WRITE to serial port 1
  */
 #define	SERIAL_READ_1(ofs)		(*((volatile unsigned char*)	\
-					(TITAN_SERIAL_BASE_1 + ofs)
+					(TITAN_SERIAL_BASE_1 + ofs)))
 
 #define	SERIAL_WRITE_1(ofs, val)	((*((volatile unsigned char*)	\
 					(TITAN_SERIAL_BASE_1 + ofs))) = val)

-- 
Regards,

	Mariusz Kozlowski
