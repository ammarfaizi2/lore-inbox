Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWKBPUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWKBPUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWKBPUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:20:53 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:12455 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750935AbWKBPUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:20:52 -0500
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 0/3] fsstack updates
Date: Wed, 01 Nov 2006 22:59:28 -0500
To: linux-kernel@vger.kernel.org
Message-Id: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are some more updates to fsstack.

The first patch makes fsstack_copy_attr_all copy the inode size in addition
to all the other attributes.

The second patch introduces generic structures and functions to get/set
lower objects.

The third patch converts eCryptfs to use the generic structures and
functions introduced by the second patch.

For those interested, I set up a git repo with all the fsstack related
patches currently in mm and these three (they're still being mirrored):

git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/fsstack-2.6.git for-2.6.20

Josef "Jeff" Sipek.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

