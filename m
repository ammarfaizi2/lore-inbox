Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264240AbTJOTtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 15:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbTJOTtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 15:49:07 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:6470 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S264240AbTJOTtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 15:49:04 -0400
Date: Wed, 15 Oct 2003 20:48:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tmpfs 2/7 LTP S_ISGID dir
In-Reply-To: <20031015193404.GT7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0310152046250.6969-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Oct 15, 2003 at 07:19:46PM +0100, Hugh Dickins wrote:
> > LTP tests the filesystem on /tmp: many failures when tmpfs because
> > it missed the way giddy directories hand down their gid.  Also fix
> > ramfs and hugetlbfs.
> 
> *the* way?  I can think of at least two...

You mean, the way they do directories and the way they do non-directories?
Or, the way they do it if they do it, and the way they do it if they don't?
Or something else?  Please, share your thought!

Thanks,
Hugh

