Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268239AbUIWDyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268239AbUIWDyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 23:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUIWDyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 23:54:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10180 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268239AbUIWDyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:54:01 -0400
Date: Wed, 22 Sep 2004 23:53:34 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] xattr consolidation v3
Message-ID: <Xine.LNX.4.44.0409222342090.447-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches are an update the previous set of xattr 
consolidation patches (v2), posted 18/09.

Changes since then:
- Address listxattr race using patch from Andreas Gruenbacher
- Update ->list methods: ext3 & ext2 now only make one pass over the 
  xattr handlers.
- Add documentation (with minor modifications) by Will Dyson.
- Changed coding style to match the rest of fs/xattr.c
- Update LSM inode_listsecurity hook with length of list buffer.
- Retested everything.

Please review and apply if ok.


- James
-- 
James Morris
<jmorris@redhat.com>





