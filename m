Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbWF1DuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbWF1DuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 23:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWF1DuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 23:50:18 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:61997 "EHLO
	asav04.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S932714AbWF1DuR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 23:50:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FANyXoUSBSg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [git pull] Input update for 2.6.17
Date: Tue, 27 Jun 2006 23:50:15 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606272350.15948.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from:

        git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git

It fixes broken hardware autorepeat in atkbd, adds a new key mapping
to wistron driver and fixes buffer overrun in db9.

Diffstat:

 joystick/db9.c      |    2 +-
 keyboard/atkbd.c    |    2 +-
 misc/wistron_btns.c |   19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

Changelog:

Dmitry Torokhov:
      Input: atkbd - fix hardware autorepeat

Eric Sesterhenn:
      Input: db9 - fix potential buffer overrun

Frank de Lange:
      Input: wistron - add mapping for Wistron MS 2111

-- 
Dmitry
