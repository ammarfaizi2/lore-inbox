Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279708AbRJ0CJ5>; Fri, 26 Oct 2001 22:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279719AbRJ0CJo>; Fri, 26 Oct 2001 22:09:44 -0400
Received: from femail27.sdc1.sfba.home.com ([24.254.60.17]:56552 "EHLO
	femail27.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S279708AbRJ0CJZ>; Fri, 26 Oct 2001 22:09:25 -0400
Date: Fri, 26 Oct 2001 22:13:27 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-ac2 alpha missing ')'
Message-ID: <20011026221327.A14846@zero>
In-Reply-To: <20011026184315.A3069@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011026184315.A3069@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Fri, Oct 26, 2001 at 06:43:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

fixes typo

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.13-ac2-time.diff"

diff -urN linux-2.4.13-ac2/arch/alpha/kernel/time.c linux-2.4.13-ac2-patched/arch/alpha/kernel/time.c
--- linux-2.4.13-ac2/arch/alpha/kernel/time.c	Fri Oct 26 21:21:26 2001
+++ linux-2.4.13-ac2-patched/arch/alpha/kernel/time.c	Fri Oct 26 22:02:59 2001
@@ -209,7 +209,7 @@
 		return cc;
 
 	if (cc < (cpu_hz[index].min - FREQ_DEVIATION)
-	    || cc > (cpu_hz[index].max + FREQ_DEVIATION)
+	    || cc > (cpu_hz[index].max + FREQ_DEVIATION))
 		return 0;
 
 	return cc;

--ReaqsoxgOBHFXBhH--
