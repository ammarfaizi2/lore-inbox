Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXJ5K>; Wed, 24 Jan 2001 04:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAXJ4t>; Wed, 24 Jan 2001 04:56:49 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:42966 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129375AbRAXJ4m>; Wed, 24 Jan 2001 04:56:42 -0500
Date: Wed, 24 Jan 2001 15:25:16 +0530 (IST)
From: V Ganesh <ganesh@veritas.com>
Message-Id: <200101240955.PAA28367@vxindia.veritas.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com
Subject: inode->i_dirty_buffers redundant ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

now that we have inode->i_mapping->dirty_pages, what do we need
inode->i_dirty_buffers for ? I understand the latter was added for the O_SYNC
changes before dirty_pages came into the picture. but now both seem to be
doing more or less the same thing.

ganesh
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
