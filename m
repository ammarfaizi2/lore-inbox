Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269242AbUISOqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbUISOqr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 10:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUISOqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 10:46:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269242AbUISOqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 10:46:45 -0400
Date: Sun, 19 Sep 2004 10:46:18 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andreas Gruenbacher <agruen@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] xattr consolidation v2 - generic xattr API
In-Reply-To: <200409191213.57977.agruen@suse.de>
Message-ID: <Xine.LNX.4.44.0409191044210.17989-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004, Andreas Gruenbacher wrote:

> Documentation/filesystems/Locking seems to be accurate.

There's an out of date comment in fs/devpts/xattr.c (which is no excuse 
for screwing it up though).

> The old handler API was fine at the FS level where locking was guaranteed 
> anyways. At the VFS level we should do better. Passing in the buffer and the 
> buffer size at the same time gets us rid of the problem without requiring any 
> locking.

Ok, I'll incorporate this and resubmit the patches soon.


- James
-- 
James Morris
<jmorris@redhat.com>


