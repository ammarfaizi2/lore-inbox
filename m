Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSFRDBS>; Mon, 17 Jun 2002 23:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317289AbSFRDBR>; Mon, 17 Jun 2002 23:01:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36509 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317286AbSFRDBR>;
	Mon, 17 Jun 2002 23:01:17 -0400
Date: Mon, 17 Jun 2002 19:56:11 -0700 (PDT)
Message-Id: <20020617.195611.61846581.davem@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: ext2 errors w/2.5.x
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I started seeing these occaisionally on my SMP boxes about a month or
two ago, is anyone else seeing something similar?

EXT2-fs error (device sd(8,17)): ext2_find_entry: zero-length directory entry

Upon reboot e2fsck is forced to run (since the partition is marked as
having errors by the kernel) and no problems are discovered.

Any clues?
