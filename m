Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbUJWXZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUJWXZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbUJWXZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:25:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:50659 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261336AbUJWXZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:25:12 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9: access permission filesystem 0.17
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sun, 24 Oct 2004 01:25:07 +0200
Message-ID: <87lldxyq3w.fsf@goat.bogus.local>
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
- updated to 2.6.9

This patch is available at:
<http://www.olafdietsche.de/linux/accessfs/>

Regards, Olaf.
