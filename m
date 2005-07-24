Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVGXOgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVGXOgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 10:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVGXOgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 10:36:35 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:42944 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261248AbVGXOge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 10:36:34 -0400
Date: Sun, 24 Jul 2005 16:36:34 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH NFS 0/3] Cleanup/fix nfs_block_size() and nfs_block_bits()
Message-ID: <20050724143634.GA19896@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH NFS 0/3] Cleanup/fix nfs_block_size() and nfs_block_bits()

The Plan 9 filesystem for Linux had some code which wrongly calculated
the size of blocks.  A comment said this code has been taken from NFS.

Patch 3 of this series contains a fix for the bug, the first two patches
are preparation work and shouldn't change the results.  I didn't went so
far and actually test the patch, so please be careful. =)  Compiles fine
here, at least.

Rene
