Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRIOVYB>; Sat, 15 Sep 2001 17:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273072AbRIOVXv>; Sat, 15 Sep 2001 17:23:51 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:63536 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S273065AbRIOVXk>; Sat, 15 Sep 2001 17:23:40 -0400
Subject: Re: [PATCH] (Updated) AMD 761 AGP GART Support
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com, laughing@shared-source.org
Cc: linux-kernel@vger.kernel.org, juhl@eisenstein.dk
In-Reply-To: <1000587574.32707.80.camel@phantasy>
In-Reply-To: <1000587574.32707.80.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 17:24:37 -0400
Message-Id: <1000589084.32705.97.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-15 at 16:59, Robert Love wrote:
> the following patch adds signature for the AMD 761 to the AGP GART
> code.  It has been tested and works.  Please, apply.

Thanks to Jesper Juhl, I noticed the config name was not updated (the
help entry is, though) to reflect support of the AMD 761.  Please append
this to my previous patch, and apply both.  It applies to both trees.
Thanks.


diff -urN linux-2.4.9-ac10/drivers/char/ linux/drivers/char/Config.in 
--- linux-2.4.9-ac10/drivers/char/Config.in	Sat Sep 15 17:02:51 2001
+++ linux/drivers/char/Config.in	Sat Sep 15 17:20:38 2001
@@ -208,7 +208,7 @@
    bool '  Intel 440LX/BX/GX and I815/I840/I850 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815 (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
-   bool '  AMD Irongate support' CONFIG_AGP_AMD
+   bool '  AMD Irongate and 761 support' CONFIG_AGP_AMD
    bool '  Generic SiS support' CONFIG_AGP_SIS
    bool '  ALI chipset support' CONFIG_AGP_ALI
    bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

