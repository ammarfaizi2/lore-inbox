Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSGFRzC>; Sat, 6 Jul 2002 13:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSGFRzC>; Sat, 6 Jul 2002 13:55:02 -0400
Received: from [63.147.7.150] ([63.147.7.150]:51708 "EHLO ducks.huff20may77.us")
	by vger.kernel.org with ESMTP id <S315709AbSGFRzA>;
	Sat, 6 Jul 2002 13:55:00 -0400
Date: Sat, 6 Jul 2002 13:56:13 -0400
Message-Id: <200207061756.g66HuDw27281@ducks.huff20may77.us>
From: "Edward J. Huff" <edward.huff@acm.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ip-sysctl.txt spelling corrections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Naur linux-2.5.25/Documentation/networking/ip-sysctl.txt linux-2.5.25.mod/Documentation/networking/ip-sysctl.txt
--- linux-2.5.25/Documentation/networking/ip-sysctl.txt	Fri Jul  5 19:42:22 2002
+++ linux-2.5.25.mod/Documentation/networking/ip-sysctl.txt	Sat Jul  6 13:54:21 2002
@@ -89,7 +89,7 @@
 
 tcp_retries1 - INTEGER
 	How many times to retry before deciding that something is wrong
-	and it is necessary to report this suspection to network layer.
+	and it is necessary to report this suspicion to network layer.
 	Minimal RFC value is 3, it is default, which corresponds
 	to ~3sec-8min depending on RTO.
 
@@ -185,7 +185,7 @@
 	
 tcp_max_syn_backlog - INTEGER
 	Maximal number of remembered connection requests, which are
-	still did not receive an acknowledgement from connecting client.
+	still did not receive an acknowledgment from connecting client.
 	Default value is 1024 for systems with more than 128Mb of memory,
 	and 128 for low memory machines. If server suffers of overload,
 	try to increase this number.
@@ -200,7 +200,7 @@
 	Enable select acknowledgments (SACKS).
 
 tcp_fack - BOOLEAN
-	Enable FACK congestion avoidance and fast restransmission.
+	Enable FACK congestion avoidance and fast retransmission.
 	The value is not used, if tcp_sack is not enabled.
 
 tcp_dsack - BOOLEAN
@@ -256,7 +256,7 @@
 
 	pressure: when amount of memory allocated by TCP exceeds this number
 	of pages, TCP moderates its memory consumption and enters memory
-	pressure mode, which is exited when memory consumtion falls
+	pressure mode, which is exited when memory consumption falls
 	under "low".
 
 	high: number of pages allowed for queueing by all TCP sockets.
@@ -278,7 +278,7 @@
 tcp_rfc1337 - BOOLEAN
 	If set, the TCP stack behaves conforming to RFC1337. If unset,
 	we are not conforming to RFC, but prevent TCP TIME_WAIT
-	asassination.	
+	assassination.   
 	Default: 0
 
 ip_local_port_range - 2 INTEGERS
@@ -295,7 +295,7 @@
 	2000 connections per second to systems supporting timestamps.
 
 ip_nonlocal_bind - BOOLEAN
-	If set, allows processes to bind() to non-local IP adresses,
+	If set, allows processes to bind() to non-local IP addresses,
 	which can be quite useful - but may break some applications.
 	Default: 0
 
