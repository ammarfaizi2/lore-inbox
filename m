Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSJOM7u>; Tue, 15 Oct 2002 08:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbSJOM7u>; Tue, 15 Oct 2002 08:59:50 -0400
Received: from thunk.org ([140.239.227.29]:55501 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262806AbSJOM7u>;
	Tue, 15 Oct 2002 08:59:50 -0400
Date: Tue, 15 Oct 2002 09:05:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015130542.GB31235@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <3DAB9DA5.42008138@digeo.com> <20021015053118.GA15552@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015053118.GA15552@clusterfs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:31:18PM -0600, Andreas Dilger wrote:
> There's a "goto bad_block" in that function, and it enters _after_
> block is set (block is a local variable), so it is impossible for
> it to have a valid value.

Thanks, I'll fix that the xattr-ext2 and xattr-ext3 patches.

							- Ted
