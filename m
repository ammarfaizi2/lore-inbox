Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271158AbTHCLyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 07:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271159AbTHCLyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 07:54:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21993 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271158AbTHCLyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 07:54:16 -0400
Date: Sun, 3 Aug 2003 13:54:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, davem@redhat.com,
       netfilter-devel@lists.netfilter.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.4 patch] add some ipv6 netfilter Configure.help entries
Message-ID: <20030803115410.GT16426@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below against 2.4.22-pre10 adds some missing ipv6 netfilter 
entries to Configure.help (texts stolen from 2.6.0-test2).

Please apply
Adrian

--- linux-2.4.22-pre10-full/Documentation/Configure.help.old	2003-08-03 13:46:47.000000000 +0200
+++ linux-2.4.22-pre10-full/Documentation/Configure.help	2003-08-03 13:50:39.000000000 +0200
@@ -2982,6 +2982,47 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
+CONFIG_IP6_NF_MATCH_RT
+  rt matching allows you to match packets based on the routing
+  header of the packet.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
+
+CONFIG_IP6_NF_MATCH_OPTS
+  This allows one to match packets based on the hop-by-hop
+  and destination options headers of a packet.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
+
+CONFIG_IP6_NF_MATCH_FRAG
+  frag matching allows you to match packets based on the fragmentation
+  header of the packet.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
+
+CONFIG_IP6_NF_MATCH_HL
+  HL matching allows you to match packets based on the hop
+  limit of the packet.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
+
+CONFIG_IP6_NF_MATCH_IPV6HEADER
+  This module allows one to match packets based upon
+  the ipv6 extension headers.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
+
+CONFIG_IP6_NF_MATCH_AHESP
+  This module allows one to match AH and ESP packets.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
+
 length match support
 CONFIG_IP6_NF_MATCH_LENGTH
   This option allows you to match the length of a packet against a
