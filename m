Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbTG1NZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbTG1NZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:25:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:5589 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S269523AbTG1NZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:25:27 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test2: access permission filesystem 0.16
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Mon, 28 Jul 2003 15:40:37 +0200
Message-ID: <87el0a7oru.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch adds a new permission managing file system.
Furthermore, it adds two modules, which make use of this file system.

One module allows granting capabilities based on user-/groupid. The
second module allows to grant access to lower numbered ports based on
user-/groupid, too.

Changes:
- fixed dependency to CONFIG_NET_HOOKS
- fixed dependency to CONFIG_SECURITY
- minor cleanup
- updated to 2.6.0-test2

This patch is available at:
<http://www.olafdietsche.de/linux/accessfs/>

Regards, Olaf.
