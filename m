Return-Path: <linux-kernel-owner+w=401wt.eu-S1423083AbWLVOp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423083AbWLVOp1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423099AbWLVOp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:45:27 -0500
Received: from www17.your-server.de ([213.133.104.17]:1604 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423083AbWLVOp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:45:27 -0500
Message-ID: <458BEF35.5010608@m3y3r.de>
Date: Fri, 22 Dec 2006 15:44:05 +0100
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061126)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add .gitignore file for relocs in arch/i386
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Add .gitignore file for relocs in arch/i386
From: Thomas Meyer <thomas@m3y3r.de>

Due the changes to make the kernel relocateable a new file is created 
during the build process.

Signed-Off-By: Thomas Meyer <thomas@m3y3r.de>
---

This makes my git stauts command happy again.

---

--- /dev/null	2000-10-22 01:01:00.000000000 +0200
+++ arch/i386/boot/compressed/.gitignore	2006-12-22 15:36:47.000000000 +0100
@@ -0,0 +1 @@
+relocs


