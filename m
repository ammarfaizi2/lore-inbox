Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUA1Q3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 11:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbUA1Q3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 11:29:52 -0500
Received: from cibs9.sns.it ([192.167.206.29]:32782 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S265973AbUA1Q3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 11:29:51 -0500
Date: Wed, 28 Jan 2004 17:29:28 +0100 (CET)
From: venom@sns.it
To: Christoph Hellwig <hch@infradead.org>
cc: Dave Kleikamp <shaggy@austin.ibm.com>,
       Florian Huber <florian.huber@mnet-online.de>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
In-Reply-To: <20040128093851.A26131@infradead.org>
Message-ID: <Pine.LNX.4.43.0401281726290.1845-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Christoph Hellwig wrote:

> Date: Wed, 28 Jan 2004 09:38:51 +0000
> From: Christoph Hellwig <hch@infradead.org>
> Then you need to shrink the filesystem.  As long as the space isn't used
> yet it's rather trivial for most ondisk formats, but you absolutely need
> to do it to be safe.
>

perfect! In fact that is what I am used to do.
than would be optimum to be able to shrink a FS on line, and not
all linux FS can do that. The real problem is that somehow not all know about
this and are not aware, as you can see from this thread. maybe should be
added somethninmg about this is kernel documentation?

Luigi

