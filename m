Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269360AbUINMVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269360AbUINMVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269358AbUINMUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:20:39 -0400
Received: from outmx002.isp.belgacom.be ([195.238.3.52]:12434 "EHLO
	outmx002.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S269329AbUINLrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:47:03 -0400
Message-ID: <4146DA7D.80504@246tNt.com>
Date: Tue, 14 Sep 2004 13:48:13 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/9] Small updates for Freescale MPC52xx
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/13 21:16:32+02:00 tnt@246tNt.com
#   ppc: Fix missing include in Freescale MPC52xx syslib
#  
#   pgtable.h is needed for _PAGE_IO
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/syslib/mpc52xx_setup.c
#   2004/09/13 21:16:20+02:00 tnt@246tNt.com +1 -0
#   ppc: Fix missing include in Freescale MPC52xx syslib
#
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c 
b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c   2004-09-14 12:47:30 +02:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c   2004-09-14 12:47:30 +02:00
@@ -23,6 +23,7 @@
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
 #include <asm/ocp.h>
+#include <asm/pgtable.h>
 #include <asm/ppcboot.h>

 extern bd_t __res;
