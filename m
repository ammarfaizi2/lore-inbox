Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWCSLUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWCSLUr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 06:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWCSLUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 06:20:47 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:44510 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751476AbWCSLUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 06:20:46 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 0/3] swsusp and pm changes
Date: Sun, 19 Mar 2006 12:05:05 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603191205.06193.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first two of the following patches are resends of the patches I posted
yesterday, with some minor changes.

The most important is the 1/3 patch, because the userland suspend is partially
broken without it.  The changes in this patch have been acked by Pavel.

The 2/3 patch is a safety measure and everything should work without it, but
may break eg. if the user switches back to X while freezing processes.
It's generally a rework of the changes that have been acked already.

The 3/3 patch adds an ioctl() that will allow us to implement the
suspend-to-disk-and-ram functionality in the userland suspend tools.

Please apply.

Greetings,
Rafael

