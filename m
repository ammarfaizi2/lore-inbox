Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130224AbRCCBzT>; Fri, 2 Mar 2001 20:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130225AbRCCBzJ>; Fri, 2 Mar 2001 20:55:09 -0500
Received: from anime.net ([63.172.78.150]:60679 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S130224AbRCCByx>;
	Fri, 2 Mar 2001 20:54:53 -0500
Date: Fri, 2 Mar 2001 17:55:25 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Chris Mason <mason@suse.com>
cc: Steve Lord <lord@sgi.com>, Jeremy Hansen <jeremy@xxedgexx.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's 
In-Reply-To: <383290000.983560664@tiny>
Message-ID: <Pine.LNX.4.30.0103021753420.31913-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Chris Mason wrote:
> For why ide is beating scsi in this benchmark...make sure tagged queueing
> is on (or increase the queue length?).  For the xlog.c test posted, I would
> expect scsi to get faster than ide as the size of the write increases.

I have seen that many drives either have a pathetically small queue or
have completely broken tagged queueing. I guess thats what happens when
most vendors target their hardware for micro$oft.

-Dan

