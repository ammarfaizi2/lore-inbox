Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992828AbWJUHNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992828AbWJUHNQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWJUHNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:13:16 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:9863 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932246AbWJUHNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:13:15 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 00 of 23] struct file: Use struct path
Message-Id: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:25 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The struct file changes in the following patches were suggested by Al Viro
during the discussion of struct path almost a week ago.

The first patch changes struct file to use struct path instead of just
having struct dentry and struct vfsmount pointers.

The remaining patches change several filesystem, the kernel/ and mm/
directories, as well as the i386 and x86_64 arch code.

These patches depend on the struct path patches from October 18th already in
-mm.

102 files changed, 463 insertions(+), 461 deletions(-)

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>


