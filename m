Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <169016-27300>; Fri, 5 Feb 1999 07:23:11 -0500
Received: by vger.rutgers.edu id <161507-27302>; Fri, 5 Feb 1999 07:22:30 -0500
Received: from viking.informatik.uni-bremen.de ([134.102.204.210]:1042 "EHLO viking.informatik.uni-bremen.de" ident: "steenbo") by vger.rutgers.edu with ESMTP id <168508-27300>; Fri, 5 Feb 1999 07:19:47 -0500
Date: Fri, 5 Feb 1999 14:38:28 +0100
Message-Id: <199902051338.OAA00796@viking.informatik.uni-bremen.de>
From: Hauke <steenbo@viking.informatik.uni-bremen.de>
To: linux-kernel@vger.rutgers.edu
Cc: card@Linux.EU.Org
Subject: ACL-Support for Ext2
Sender: owner-linux-kernel@vger.rutgers.edu

Hello!  

We fixed some bugs in the ACL support for ext2 from Remy Card found on tsx-11.

Based on linux-2.1.99-ext2fs-0.6alpha3-wip11.diff we built a newpatch for the
linux-2.2.0-pre9-kernel. Also we fixed some bugs in aclutils-0.1.tar.gz. At
last we applied the e2fsprogs-1.12-WIP-acl-support.patch on e2fsprogs-1.14 and
made a change in pass1.c so that the blocks used for acl´s are checked by
e2fsck. We built a system with ACL support that seems to work (with some
restrictions).

At the moment we are working on our own, but would like to get into contact
with anyone working on the same.

You can get our results from

http://aerobee.informatik.uni-bremen.de/acl_eng.html

Hauke Steenbock
Matthias Riese

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
