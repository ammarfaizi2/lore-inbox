Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287565AbSA0DKf>; Sat, 26 Jan 2002 22:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287572AbSA0DKZ>; Sat, 26 Jan 2002 22:10:25 -0500
Received: from [208.179.59.195] ([208.179.59.195]:41293 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S287565AbSA0DKO>; Sat, 26 Jan 2002 22:10:14 -0500
Message-ID: <3C536FB1.8080402@blue-labs.org>
Date: Sat, 26 Jan 2002 22:10:41 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.18-pre7 compile error || missing ipt_ah goodies
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone forget to add ipt_ah files?  :)


--- linux.orig/net/ipv4/netfilter/Makefile      Tue Oct 30 23:08:12 2001
+++ linux/net/ipv4/netfilter/Makefile   Wed Jan 23 20:24:37 2002
@@ -56,6 +56,7 @@
 obj-$(CONFIG_IP_NF_MATCH_MULTIPORT) += ipt_multiport.o
 obj-$(CONFIG_IP_NF_MATCH_OWNER) += ipt_owner.o
 obj-$(CONFIG_IP_NF_MATCH_TOS) += ipt_tos.o
+obj-$(CONFIG_IP_NF_MATCH_AH_ESP) += ipt_ah.o ipt_esp.o


ld: cannot open ipt_ah.o: No such file or directory
make[3]: *** [netfilter.o] Error 1
make[3]: Leaving directory `/usr/local/src/linux/net/ipv4/netfilter'

-d


