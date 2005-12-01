Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVLAL1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVLAL1h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVLAL1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:27:37 -0500
Received: from netzweb.gamper-media.ch ([157.161.128.137]:45839 "EHLO
	ns1.netzweb.ch") by vger.kernel.org with ESMTP id S932152AbVLAL1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:27:36 -0500
From: "Miro Dietiker, MD Systems" <info@md-systems.ch>
To: <linux-kernel@vger.kernel.org>
Subject: Networking delay & timeout
Date: Thu, 1 Dec 2005 12:27:04 +0100
Organization: MD Systems
Message-ID: <000001c5f66a$28b76100$4001a8c0@MDSYSPORT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having some trouble with "general networking", using simple Ethernet
Gigabit interfaces on a routing computer (routing in between eth0,
eth1).

My network has 10 Servers and a public internet gateway. Router does arp
proxying.
If I "ping" from a Internet-computer (unrecently used before to connect
to that server), my firewall produces Initial delays around 1000ms!

C:\>ping abcde
Ping frankonia [X.X.X.X] mit 32 Bytes Daten:
Antwort von X.X.X.X: Bytes=32 Zeit=441ms TTL=53
Antwort von X.X.X.X: Bytes=32 Zeit=33ms TTL=53
Antwort von X.X.X.X: Bytes=32 Zeit=32ms TTL=53
Antwort von X.X.X.X: Bytes=32 Zeit=32ms TTL=53

If i ping later on, delay remains that low.

In some certain cases, the target even is temporarily unreachable...

Is there anyone who can tell me how to debug the source of this delay?
Is it possible to reduce it?
The initial delay seems to be sourced by the linux router, while the
temporary unavailability seems to be sourced by the target server,
temporarily not answering to packets!

Do you have any suggestion for analternative list to post this question?

+-------------------------------+  +-------------------------------+
| Miro Dietiker                 |  | MD Systems Miro Dietiker      |
+-------------------------------+  +-------------------------------+


