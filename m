Return-Path: <linux-kernel-owner+w=401wt.eu-S932628AbWLMJdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWLMJdR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWLMJdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:33:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:33137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932628AbWLMJdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:33:16 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 04:33:15 EST
X-Authenticated: #222744
From: "Dieter Ferdinand" <dieter.ferdinand@gmx.de>
To: linux-kernel@vger.kernel.org
Date: Wed, 13 Dec 2006 10:26:38 +1
MIME-Version: 1.0
Subject: server don't accept ip-connections from linux
Reply-to: Dieter.Ferdinand@gmx.de
Message-ID: <457FD55E.13765.202391D@dieter.ferdinand.gmx.de>
X-mailer: Pegasus Mail for Windows (4.31, DE v4.31 R1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i have a big problem: some servers send a rst-packet or don't answer if i 
want to open a connection with them.

this happens with the web-server with ip 15.200.6.123 and my smc-
barricade router/printserver.

if i make a connection from windows or linux with kernel 2.2, it works, with 
kernel 2.4, i get a rst or no answer and the connection is closed.

i don't know, what is the difference of the tcp-packets from windows/kernel 
2.2 and linux with kernel 2.4. but with kernel 2.4 i have trouble with some 
servers.

i check the packets with an analyser and make some test. if i disable ecn 
with "echo 0x0 > /proc/sys/net/ipv4/tcp_ecn" it works, with ecn enabled, it 
don't work.

goodby

Schau auch einmal auf meine Homepage (http://go.to/dieter-ferdinand).
Dort findest du Information zu Linux, Novell, Win95, WinNT, ...

