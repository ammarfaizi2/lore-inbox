Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269300AbUINMCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269300AbUINMCd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUINMBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:01:45 -0400
Received: from outmx023.isp.belgacom.be ([195.238.2.204]:38286 "EHLO
	outmx023.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S269300AbUINL7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:59:40 -0400
Message-ID: <4146DD6B.8070502@246tNt.com>
Date: Tue, 14 Sep 2004 14:00:43 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 7/9] Small updates for Freescale MPC52xx
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
#   2004/09/14 12:03:19+02:00 tnt@246tNt.com
#   ppc: Update Freescale MPC52xx documentation / maintainer
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# MAINTAINERS
#   2004/09/14 12:03:04+02:00 tnt@246tNt.com +8 -0
#   ppc: Update Freescale MPC52xx documentation / maintainer
#
# Documentation/powerpc/mpc52xx.txt
#   2004/09/14 12:03:04+02:00 tnt@246tNt.com +1 -10
#   ppc: Update Freescale MPC52xx documentation / maintainer
#
diff -Nru a/Documentation/powerpc/mpc52xx.txt 
b/Documentation/powerpc/mpc52xx.tx
t
--- a/Documentation/powerpc/mpc52xx.txt 2004-09-14 12:48:06 +02:00
+++ b/Documentation/powerpc/mpc52xx.txt 2004-09-14 12:48:06 +02:00
@@ -1,7 +1,7 @@
 Linux 2.6.x on MPC52xx family
 -----------------------------

-For the latest info, go to http://www.246tNt.com/mpc52xx/state.txt
+For the latest info, go to http://www.246tNt.com/mpc52xx/

 To compile/use :

@@ -37,12 +37,3 @@
  - Of course, I inspired myself from the 2.4 port. If you think I forgot to
    mention you/your company in the copyright of some code, I'll correct it
    ASAP.
- - The codes wants the MBAR to be set at 0xf0000000 by the bootloader. It's
-   mapped 1:1 with the MMU. If for whatever reason, you want to change 
this,
-   beware that some code depends on the 0xf0000000 address and other 
depends
-   on the 1:1 mapping.
- - Most of the code assumes that port multiplexing, frequency 
selection, ...
-   has already been done. IMHO this should be done as early as possible, in
-   the bootloader. If for whatever reason you can't do it there, do it 
in the
-   platform setup code (if U-Boot) or in the arch/ppc/boot/simple/... (if
-   DBug)
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS       2004-09-14 12:48:06 +02:00
+++ b/MAINTAINERS       2004-09-14 12:48:06 +02:00
@@ -1301,6 +1301,14 @@
 L:     linuxppc-dev@lists.linuxppc.org
 S:     Maintained

+LINUX FOR POWERPC EMBEDDED MPC52XX
+P:     Sylvain Munaut
+M:     tnt@246tNt.com
+W:     http://www.246tNt.com/mpc52xx/
+W:     http://www.penguinppc.org/
+L:     linuxppc-embedded@lists.linuxppc.org
+S:     Maintained
+
 LINUX FOR POWERPC EMBEDDED PPC4XX
 P:     Matt Porter
 M:     mporter@kernel.crashing.org

