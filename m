Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272980AbRIYTcC>; Tue, 25 Sep 2001 15:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272966AbRIYTbv>; Tue, 25 Sep 2001 15:31:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43738 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272953AbRIYTbf>;
	Tue, 25 Sep 2001 15:31:35 -0400
Date: Tue, 25 Sep 2001 15:31:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
In-Reply-To: <shshetr3xgv.fsf@charged.uio.no>
Message-ID: <Pine.GSO.4.21.0109251521030.24321-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 Sep 2001, Trond Myklebust wrote:

> >>>>> " " == Alexander Viro <viro@math.psu.edu> writes:
> 
>      > OK, let me put it that way: we need to turn stat() into method
>      > call rather than blind access to inode fields.  Then all these
>      > problems will be very easy to deal with.
> 
> Yes *please*! Finally we could introduce proper support for 64-bit
> inode numbers too!

Right.  As soon as userland is audited for places where it uses int
for storing inode numbers - just a couple of months after MS fixes
all security holes in their software.  By then we'll need 128bit time_t,
though...

