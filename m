Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261336AbRFFUnC>; Wed, 6 Jun 2001 16:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbRFFUmx>; Wed, 6 Jun 2001 16:42:53 -0400
Received: from gateway.penguincomputing.com ([63.143.102.194]:28668 "EHLO
	foo.penguincomputing.com") by vger.kernel.org with ESMTP
	id <S261296AbRFFUmk>; Wed, 6 Jun 2001 16:42:40 -0400
Date: Wed, 6 Jun 2001 13:42:20 -0700 (PDT)
From: Jim Wright <jwright@penguincomputing.com>
Reply-To: Jim Wright <jwright@penguincomputing.com>
To: Andre Hedrick <andre@linux-ide.org>, Arjan van de Ven <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>
cc: Jim Wright <jwright@penguincomputing.com>
Subject: [PATCH] Promise ATARAID
Message-ID: <Pine.LNX.4.33.0106051734220.14480-100000@foo.penguincomputing.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Working with 2.4.5-ac8, a "_" was omitted in the Config.in file's rule
for the Promise ATARAID card.  The following will fix that.


--- drivers/ide/Config.in.orig	Tue Jun  5 17:46:08 2001
+++ drivers/ide/Config.in	Tue Jun  5 17:46:19 2001
@@ -180,6 +180,6 @@
    define_bool CONFIG_BLK_DEV_IDE_MODES n
 fi

-dep_tristate 'Support Promise software RAID' CONFIG_BLKDEV_ATARAID $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL
+dep_tristate 'Support Promise software RAID' CONFIG_BLK_DEV_ATARAID $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL

 endmenu


