Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUHWUQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUHWUQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUHWUOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:14:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267429AbUHWTG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:06:58 -0400
Date: Mon, 23 Aug 2004 15:06:41 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH][2/7] xattr consolidation - LSM hook changes
In-Reply-To: <20040823200353.A20114@infradead.org>
Message-ID: <Xine.LNX.4.44.0408231506130.13988-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Christoph Hellwig wrote:

> On Mon, Aug 23, 2004 at 02:16:17PM -0400, James Morris wrote:
> > This patch replaces the dentry parameter with an inode in the LSM
> > inode_{set|get|list}security hooks, in keeping with the ext2/ext3 code.
> > dentries are not needed here.
> 
> Given that the actual methods take a dentry this sounds like a bad design.
> Can;t you just pass down the dentry through all of the ext2 interfaces?

Yes, this can be done, although all that's needed is the inode.


- James
-- 
James Morris
<jmorris@redhat.com>


