Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbREYTYu>; Fri, 25 May 2001 15:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261778AbREYTYk>; Fri, 25 May 2001 15:24:40 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:41084
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S261771AbREYTYb>; Fri, 25 May 2001 15:24:31 -0400
Date: Fri, 25 May 2001 21:24:22 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: cort@fsmlabs.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __init -> __initdata for drivers/ide/feature.c (244-ac16)
Message-ID: <20010525212422.A851@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch changes an __init to an __initdata. Applies
against 2.4.4-ac16.


--- linux-244-ac16-clean/arch/ppc/kernel/feature.c      Sat May 19 21:06:18 2001+++ linux-244-ac16/arch/ppc/kernel/feature.c    Mon May 21 00:04:35 2001
@@ -267,7 +267,7 @@
 static struct board_features_t {
        char*   compatible;
        u32     features;
-} board_features_datas[] __init =
+} board_features_datas[] __initdata =
 {
   {    "AAPL,PowerMac G3",     0                               }, /* Beige G3 */
   {    "iMac,1",               0                               }, /* First iMac (gossamer) */

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

We're going to turn this team around 360 degrees.
-Jason Kidd, upon his drafting to the Dallas Mavericks
