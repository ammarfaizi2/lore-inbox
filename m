Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTFXXT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTFXXT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:19:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:11466 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263176AbTFXXTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:19:55 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.72: access permission filesystem 0.15
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Wed, 25 Jun 2003 01:34:02 +0200
Message-ID: <87el1jrqxh.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new permission managing file system. Furthermore, it
adds two modules, which make use of this file system.

One module allows granting capabilities based on user-/groupid. The
second module allows to grant access to lower numbered ports based on
user-/groupid, too.

Changes:
- added compile time check for CONFIG_NET_HOOKS
- updated to 2.5.72

This patch is available at:
<http://www.olafdietsche.de/linux/accessfs/>

Regards, Olaf.
