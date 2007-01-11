Return-Path: <linux-kernel-owner+w=401wt.eu-S1030430AbXAKN3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbXAKN3y (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbXAKN3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:29:54 -0500
Received: from styx.suse.cz ([82.119.242.94]:55107 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030430AbXAKN3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:29:53 -0500
Date: Thu, 11 Jan 2007 14:29:48 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID core update
Message-ID: <Pine.LNX.4.64.0701111426450.4076@jikos.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull from 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus
or
	master.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive updates for HID core layer. All of them are just a simple 
few-line bugfixes.

Thanks.

---

 drivers/hid/hid-core.c  |   12 ++----------
 drivers/hid/hid-input.c |    9 +++++----
 2 files changed, 7 insertions(+), 14 deletions(-)

Adrian Drzewiecki (1):
      HID: fix mappings for DiNovo Edge Keyboard - Logitech USB BT receiver

Ahmed S. Darwish (1):
      HID: tiny patch to remove a kmalloc cast

Jiri Kosina (2):
      HID: mousepoll parameter makes no sense for generic HID
      HID: Fix DRIVER_DESC macro
