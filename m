Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132521AbRCZSGD>; Mon, 26 Mar 2001 13:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132526AbRCZSFy>; Mon, 26 Mar 2001 13:05:54 -0500
Received: from [216.161.55.93] ([216.161.55.93]:9724 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S132521AbRCZSFc>;
	Mon, 26 Mar 2001 13:05:32 -0500
Date: Mon, 26 Mar 2001 10:08:56 -0800
From: Greg KH <greg@wirex.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 toshiba module fix
Message-ID: <20010326100856.E18021@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The following patch enables the toshiba module to compile correctly on
2.2.19.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg

--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="toshiba-2.2.19.patch"

diff -Naur -X /home/greg/linux/dontdiff linux-2.2.19/drivers/char/toshiba.c linux-2.2.19-greg/drivers/char/toshiba.c
--- linux-2.2.19/drivers/char/toshiba.c	Sun Mar 25 09:45:19 2001
+++ linux-2.2.19-greg/drivers/char/toshiba.c	Mon Mar 26 09:19:08 2001
@@ -78,7 +78,7 @@
 #include<linux/proc_fs.h>
 #endif
 
-#include"toshiba.h"
+#include<linux/toshiba.h>
 
 #define TOSH_MINOR_DEV 181
 

--nmemrqcdn5VTmUEE--
