Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbSJaHE2>; Thu, 31 Oct 2002 02:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265199AbSJaHE1>; Thu, 31 Oct 2002 02:04:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:8345 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265198AbSJaHE1>;
	Thu, 31 Oct 2002 02:04:27 -0500
Date: Thu, 31 Oct 2002 02:10:52 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dax Kelson <dax@gurulabs.com>
cc: Chris Wedgwood <cw@f00f.org>, Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
In-Reply-To: <1036046904.1521.74.camel@mentor>
Message-ID: <Pine.GSO.4.21.0210310203570.13031-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 30 Oct 2002, Dax Kelson wrote:

> Without ACLs, if Sally, Joe and Bill need rw access to a file/dir, just
> create another group with just those three people in.  Over time, of

If Sally, Joe and Bill need rw access to a directory, and Joe and Bill
are using existing userland (any OS I'd seen), then Sally can easily
fuck them into the next month and not in a good way.

_That_ is the real problem.  Until that is solved (i.e. until all
userland is written up to the standards allegedly followed in writing
suid-root programs wrt hostile filesystem modifications) NO mechanism
will help you.  ACLs, huge groups, whatever - setups with that sort
of access allowed are NOT SUSTAINABLE with the current userland(s).

