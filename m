Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272085AbRHVSzI>; Wed, 22 Aug 2001 14:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272082AbRHVSy6>; Wed, 22 Aug 2001 14:54:58 -0400
Received: from zeke.inet.com ([199.171.211.198]:37541 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S272084AbRHVSyz>;
	Wed, 22 Aug 2001 14:54:55 -0400
Message-ID: <3B840002.60D13CEF@inet.com>
Date: Wed, 22 Aug 2001 13:54:58 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] typo in comment
Content-Type: multipart/mixed;
 boundary="------------E02CAA7164C869D73AA63F83"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E02CAA7164C869D73AA63F83
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan, (& etc.)

No, it's not terribly important, but in studying the networking code, I
noticed it, so here's a patch against 2.2.19.  Please apply.  (It's
attached to avoid possible mangling problems.)

Comments, questions, complaints?

Eli 
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
--------------E02CAA7164C869D73AA63F83
Content-Type: text/plain; charset=us-ascii;
 name="spelling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spelling.patch"

Index: linux/net/ipv4/route.c
===================================================================
RCS file: /opt/eli_depot/kernelCVS/linux/net/ipv4/route.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 route.c
--- linux/net/ipv4/route.c	2001/01/20 11:03:27	1.1.1.9
+++ linux/net/ipv4/route.c	2001/08/22 18:47:59
@@ -1346,7 +1346,7 @@
 #ifdef CONFIG_IP_ROUTE_VERBOSE
 	if (IN_DEV_LOG_MARTIANS(in_dev) && net_ratelimit()) {
 		/*
-		 *	RFC1812 recommenadtion, if source is martian,
+		 *	RFC1812 recommendation, if source is martian,
 		 *	the only hint is MAC header.
 		 */
 		printk(KERN_WARNING "martian source %08x for %08x, dev %s\n", saddr, daddr, dev->name);

--------------E02CAA7164C869D73AA63F83--

