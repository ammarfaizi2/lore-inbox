Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265173AbSJaDsx>; Wed, 30 Oct 2002 22:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265175AbSJaDsw>; Wed, 30 Oct 2002 22:48:52 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:59660 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265173AbSJaDsv>; Wed, 30 Oct 2002 22:48:51 -0500
Date: Thu, 31 Oct 2002 12:55:15 +0900 (JST)
Message-Id: <20021031.125515.108721967.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20021031.124459.66300488.yoshfuji@linux-ipv6.org>
References: <20021031.124459.66300488.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: ,!^C1nUj;HDn\o}#MDnZW<|oj*]iIB/>/Rj|xZ=D=hBIY#)lQ,$n#kJvDg7at|p;w0^8&4_
 OS17ezZP7m/LlFJYPF}FdcGx!,qBM:w{Ub2#M8_@n^nYT%?u+bwTsqni(z5
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021031.124459.66300488.yoshfuji@linux-ipv6.org> (at Thu, 31 Oct 2002 12:44:59 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>

Oops, I've forgot to credit myself in the source.
Please apply on top of the patch.

Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.4.6.1
retrieving revision 1.1.1.4.6.2
diff -u -r1.1.1.4.6.1 -r1.1.1.4.6.2
--- net/ipv6/addrconf.c	30 Oct 2002 18:15:04 -0000	1.1.1.4.6.1
+++ net/ipv6/addrconf.c	31 Oct 2002 03:50:36 -0000	1.1.1.4.6.2
@@ -28,6 +28,8 @@
  *						packets.
  *	YOSHIFUJI Hideaki @USAGI	:	improved accuracy of
  *						address validation timer.
+ *	YOSHIFUJI Hideaki @USAGI	:	Privacy Extensions (RFC3041)
+ *						support.
  */
 
 #include <linux/config.h>

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
