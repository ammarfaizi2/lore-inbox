Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTA2OuL>; Wed, 29 Jan 2003 09:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTA2OuL>; Wed, 29 Jan 2003 09:50:11 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:10887 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S266095AbTA2OuK>; Wed, 29 Jan 2003 09:50:10 -0500
Subject: [PATCH] 2.5.59 add one help text to net/ipv4/netfilter/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: davem@redhat.com
Cc: trivial@rustcorp.com.au, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 29 Jan 2003 07:57:07 -0700
Message-Id: <1043852227.2576.189.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a help text from 2.4.21-pre4 Configure.help which is
needed in 2.5.59 net/ipv4/netfilter/Kconfig.

Steven

--- linux-2.5.59/net/ipv4/netfilter/Kconfig.orig	Wed Jan 29 07:30:59 2003
+++ linux-2.5.59/net/ipv4/netfilter/Kconfig	Wed Jan 29 07:32:43 2003
@@ -148,6 +148,14 @@
 config IP_NF_MATCH_DSCP
 	tristate "DSCP match support"
 	depends on IP_NF_IPTABLES
+	help
+	  This option adds a `DSCP' match, which allows you to match against
+	  the IPv4 header DSCP field (DSCP codepoint).
+
+	  The DSCP codepoint can have any value between 0x0 and 0x4f.
+
+	  If you want to compile it as a module, say M here and read
+	  Documentation/modules.txt.  If unsure, say `N'.
 
 config IP_NF_MATCH_AH_ESP
 	tristate "AH/ESP match support"




