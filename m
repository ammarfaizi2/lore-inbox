Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUCPFoS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 00:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUCPFoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 00:44:18 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:47011 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S262850AbUCPFoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 00:44:17 -0500
Subject: The verdict on the future of suspending to disk?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1079408330.3403.5.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Tue, 16 Mar 2004 16:38:50 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Just wanting clarification; what are we thinking about the future of
suspend implementations? Let me throw my current
understanding/suggestion in for starters:

- Drop PM_DISK?
- Apply patches making swsusp into suspend2, leaving out freezer changes
until people are convinced the current solution is insufficient.
- Pavel keeps maintaining the end result? (I'm happy to maintain it if
he wants; I'm assuming when I say this he'll still be dealing with S3
and Patrick will be deal with PM support proper).

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

