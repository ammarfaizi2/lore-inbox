Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWIXWQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWIXWQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWIXWQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:16:16 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S1751260AbWIXWQQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:16:16 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:17628 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932130AbWIXVNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:10 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 20/28] Documentaion: update Documentation/Changes with minimum versions
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:16 +0200
Message-Id: <1159132706423-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327061478-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <11591327061478-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert P. J. Day <rpjday@mindspring.com>

Based on conversations with greg kh (and noticing a simple typo),
these are the actual minimal versions for 2.6.18.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/Changes |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/Changes b/Documentation/Changes
index 4882720..abee7f5 100644
--- a/Documentation/Changes
+++ b/Documentation/Changes
@@ -37,15 +37,14 @@ o  e2fsprogs              1.29          
 o  jfsutils               1.1.3                   # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
 o  xfsprogs               2.6.0                   # xfs_db -V
-o  pcmciautils            004
-o  pcmcia-cs              3.1.21                  # cardmgr -V
+o  pcmciautils            004                     # pccardctl -V
 o  quota-tools            3.09                    # quota -V
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
 o  nfs-utils              1.0.5                   # showmount --version
 o  procps                 3.2.0                   # ps --version
 o  oprofile               0.9                     # oprofiled --version
-o  udev                   071                     # udevinfo -V
+o  udev                   081                     # udevinfo -V
 
 Kernel compilation
 ==================
@@ -268,7 +267,7 @@ active clients.
 
 To enable this new functionality, you need to:
 
-  mount -t nfsd nfsd /proc/fs/nfs
+  mount -t nfsd nfsd /proc/fs/nfsd
 
 before running exportfs or mountd.  It is recommended that all NFS
 services be protected from the internet-at-large by a firewall where
-- 
1.4.1

