Return-Path: <linux-kernel-owner+w=401wt.eu-S965157AbWL2UzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWL2UzT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWL2UzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:55:19 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:42647 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965157AbWL2UzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:55:19 -0500
Message-id: <2444927859138811520@wsc.cz>
Subject: [PATCH 1/1] Doc: isicom, remove reserved ioctl-number
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Michael Elizabeth Chastain <mec@shout.net>
Date: Fri, 29 Dec 2006 21:55:28 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, remove reserved ioctl-number

Isicom driver no longer registers chardev with ioctl function. It used
to use for firmware loading. Remove the reserved letter (M) from
ioctl-number, so that the conflict get away.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 5bdb7cc0e955ee7724ff519a212aceb706e4814d
tree 27615584648d8776da636a527a16fed31ca51bca
parent 549237a65498ad3880cd1ca40f23f8bc942041cb
author Jiri Slaby <jirislaby@gmail.com> Fri, 29 Dec 2006 21:48:23 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 29 Dec 2006 21:48:23 +0059

 Documentation/ioctl-number.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/ioctl-number.txt b/Documentation/ioctl-number.txt
index 5a8bd5b..8f750c0 100644
--- a/Documentation/ioctl-number.txt
+++ b/Documentation/ioctl-number.txt
@@ -94,8 +94,7 @@ Code	Seq#	Include File		Comments
 'L'	00-1F	linux/loop.h
 'L'	E0-FF	linux/ppdd.h		encrypted disk device driver
 					<http://linux01.gwdg.de/~alatham/ppdd.html>
-'M'	all	linux/soundcard.h	conflict!
-'M'	00-1F	linux/isicom.h		conflict!
+'M'	all	linux/soundcard.h
 'N'	00-1F	drivers/usb/scanner.h
 'P'	all	linux/soundcard.h
 'Q'	all	linux/soundcard.h
