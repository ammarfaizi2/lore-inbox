Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423053AbWJQEwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423053AbWJQEwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 00:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423050AbWJQEwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 00:52:45 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:23006 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1423054AbWJQEwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 00:52:44 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0 of 2] fsstack: generic stackable filesystem helper functions
Message-Id: <patchbomb.1161060146@thor.fsl.cs.sunysb.edu>
Date: Tue, 17 Oct 2006 00:42:26 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: null@josefsipek.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

The following patches introduce fsstack_copy_* functions. These functions
copy inode attributes (such as {a,c,m}time, mode, etc.) from one inode to
another.

While, intended for stackable filesystems any portion of the kernel wishing
to copy inode attributes can use them.

This series consists of two patches, the first introduces the fsstack
functions, and the second makes eCryptfs a user.

Changes since previous submission:

- rename to fsstack (akpm)
- removed fstack_copy_attr_timesizes (akpm)
- move non-inlined functions to fs/stack.c (Jan Engelhardt)

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>


