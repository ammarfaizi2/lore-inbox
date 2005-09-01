Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVIASvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVIASvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVIASvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:51:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:55002 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030294AbVIASvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:51:40 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.13: access permission filesystem 0.17
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Thu, 01 Sep 2005 20:51:37 +0200
Message-ID: <87u0h4hb9i.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new permission managing file system. Furthermore,
it adds two modules, which make use of this file system.

One module allows granting capabilities based on user-/groupid. The
second module allows to grant access to lower numbered ports based on
user-/groupid, too.

Changes:
- updated to 2.6.13

This patch is available at:
<http://www.olafdietsche.de/linux/accessfs/>

Regards, Olaf.
