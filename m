Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312814AbSC0TtR>; Wed, 27 Mar 2002 14:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSC0TtH>; Wed, 27 Mar 2002 14:49:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:24595 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312814AbSC0Tsx>; Wed, 27 Mar 2002 14:48:53 -0500
Message-ID: <3CA221BF.33973067@zip.com.au>
Date: Wed, 27 Mar 2002 11:47:11 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Sandeen <sandeen@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kmem_cache_zalloc
In-Reply-To: <1017257958.16305.168.camel@stout.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:
> 
> In the interest of whittling down the changes that XFS makes to the core
> kernel, I thought I'd start throwing out some the easier self-contained
> modifications for discussion.
> 
> XFS adds a kmem_cache_zalloc function to mm/slab.c, it does what you
> might expect:  kmem_cache_alloc + memset
> 
> Is this something that might be considered for inclusion in the core
> kernel, or should we roll it back into fs/xfs?

Count me in.  Clearly a very sane thing to do.

Needs an EXPORT_SYMBOL though.

-
