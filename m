Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUGVNVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUGVNVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 09:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbUGVNVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 09:21:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:10188 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265776AbUGVNVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 09:21:41 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.7: access permission filesystem 0.17
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Thu, 22 Jul 2004 15:21:39 +0200
Message-ID: <87wu0wxjmk.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new permission managing file system. Furthermore,
it adds two modules, which make use of this file system.

One module allows granting capabilities based on user-/groupid. The
second module allows to grant access to lower numbered ports based on
user-/groupid, too.

Changes:
- minor module_param() cleanup
- updated to 2.6.7

This patch is available at:
<http://www.olafdietsche.de/linux/accessfs/>

Regards, Olaf.
