Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317527AbSFEB1U>; Tue, 4 Jun 2002 21:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317530AbSFEB1T>; Tue, 4 Jun 2002 21:27:19 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:39920 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S317527AbSFEB1T>; Tue, 4 Jun 2002 21:27:19 -0400
Date: Tue, 4 Jun 2002 18:26:35 -0700
From: Chris Wright <chris@wirex.com>
To: ipslinux@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.20 drivers/scsi/ips.c cleanup
Message-ID: <20020604182635.A9720@figure1.int.wirex.com>
Mail-Followup-To: ipslinux@us.ibm.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The IBM ServeRAID driver does not compile in recent 2.5 kernels.  The
simple patch below fixes the compilation error and has been tested at OSDL.

thanks,
-chris

--- a/drivers/scsi/ips.c	Mon May 20 15:07:16 2002
+++ b/drivers/scsi/ips.c	Tue Jun  4 15:11:01 2002
@@ -596,7 +596,7 @@
    }
 
    return (1);
-
+}
 __setup("ips=", ips_setup);
 
 #else
@@ -633,9 +633,9 @@
       }
    }
 
+}
 #endif
 
-}
 
 /****************************************************************************/
 /*                                                                          */
