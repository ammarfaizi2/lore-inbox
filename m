Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbTA1Nls>; Tue, 28 Jan 2003 08:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTA1Nls>; Tue, 28 Jan 2003 08:41:48 -0500
Received: from verein.lst.de ([212.34.181.86]:23567 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S265098AbTA1Nls>;
	Tue, 28 Jan 2003 08:41:48 -0500
Date: Tue, 28 Jan 2003 14:50:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: ext2 FS corruption with 2.5.59.
Message-ID: <20030128145054.A7217@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@digeo.com>, Oleg Drokin <green@namesys.com>,
	linux-kernel@vger.kernel.org
References: <20030123153832.A860@namesys.com> <20030124023213.63d93156.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030124023213.63d93156.akpm@digeo.com>; from akpm@digeo.com on Fri, Jan 24, 2003 at 02:32:13AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 02:32:13AM -0800, Andrew Morton wrote:
> But it isn't.  It's on inode_in_use.  It (and its pages) never get written
> out and the data gets thrown away on unmount.  Christoph has hit the same
> thing.  I bet he was running fsstress too.  Sorry about that.

Yes, I was hitting the bug in XFS's testcase 013 which is based on
fsstress.

