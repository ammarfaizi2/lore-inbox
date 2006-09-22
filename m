Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWIVMYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWIVMYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWIVMYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:24:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:18625 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932370AbWIVMYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:24:40 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.18: access permission filesystem 0.19
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Fri, 22 Sep 2006 14:24:33 +0200
Message-ID: <87eju484xq.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Constant Variable,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch adds a new permission managing file system.
Furthermore, it adds two modules, which make use of this file system.

One module allows granting capabilities based on user-/groupid. The
second module allows to grant access to lower numbered ports based on
user-/groupid, too.

Changes:
- updated to 2.6.18

This patch is available at:
<http://www.olafdietsche.de/linux/accessfs/>

Regards, Olaf.
