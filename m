Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422792AbWJLHnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422792AbWJLHnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422789AbWJLHnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:43:12 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:12718 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422792AbWJLHnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:43:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:user-agent:date:from:to:cc:subject:message-id;
        b=OSv+snkupku/4xhE9xe/nHG08JFzyu+nTzdvpbN8R2pj1341R9/qxwXsbieNZA9Ts+W60g598fjL/wmH0iE3c8kvpYIJKbl987XeyPs+Eq63O1IZaK4Jc8OcCWGAyyIqEoes3hkhRHNuZ7eSyWL5VWbhBLtCf0ouIhWmhAyIYn4=
User-Agent: quilt/0.45-1
Date: Thu, 12 Oct 2006 16:43:05 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>
Subject: [patch 0/7] fault-injection capabilities (v5)
Message-ID: <452df20e.025ef312.44f0.7578@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fault-injection capabilities patch set version 5.
Please read the mail for the patch 1/7 for details

Changes from v3 to v5 (v4 was not delivered to linux-kernel list)

- do dump_stack() on injecting failures (if verbose option enabled)

- updated to the latest kernel version
- add debugfs entries automatically at boot time
  (fault-inject-debugfs.ko has been removed)
- various bugfixes and cleanups

