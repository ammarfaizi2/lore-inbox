Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130779AbRCMCQS>; Mon, 12 Mar 2001 21:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbRCMCQI>; Mon, 12 Mar 2001 21:16:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9380 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130779AbRCMCQD>;
	Mon, 12 Mar 2001 21:16:03 -0500
Date: Mon, 12 Mar 2001 21:15:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: named pipe writes on readonly filesystems
In-Reply-To: <517520000.984449174@tiny>
Message-ID: <Pine.GSO.4.21.0103122113480.28460-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Mar 2001, Chris Mason wrote:

> Hello everyone,
> 
> Since fs/pipe.c:pipe_write() calls mark_inode_dirty, and it is legal to
> write to a named pipe on a readonly filesystem, we can end up writing an
> inode on a readonly FS.

I would check that in pipe_write()...
						Cheers,
							Al

