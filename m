Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSEQNQl>; Fri, 17 May 2002 09:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316155AbSEQNQk>; Fri, 17 May 2002 09:16:40 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:45720 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S315480AbSEQNQj>; Fri, 17 May 2002 09:16:39 -0400
Date: Fri, 17 May 2002 14:19:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: <E178h82-0001o6-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.21.0205171408560.1083-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Rusty Russell wrote:
> 
> I don't care about the size of the kernel, I care about the fact that
> the compile is 5x slower than it needs to be because the contents of
> every pre-processed file depends on where the kernel tree happens to
> be (see http://ccache.samba.org)

All power to you, speeding up your (and others') builds.  All power
to you, eliminating the absolute pathnames (which I abhor for making
comparisons harder).  But some do care about the size of the kernel
too: your additional __FUNCTION__ hurts them and doesn't help you.

Hugh

