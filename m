Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271275AbRHOQ25>; Wed, 15 Aug 2001 12:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271274AbRHOQ2h>; Wed, 15 Aug 2001 12:28:37 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:28036 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271271AbRHOQ2f>; Wed, 15 Aug 2001 12:28:35 -0400
Date: Wed, 15 Aug 2001 17:30:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "David S. Miller" <davem@redhat.com>, thockin@sun.com,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
In-Reply-To: <20010815163256.E7382@athlon.random>
Message-ID: <Pine.LNX.4.21.0108151725490.1005-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Andrea Arcangeli wrote:
> 
> Since 2.2 we have the free_pgtables to release the pagetables under
> unused pgd slots, that was used to work pretty well last time I checked.

Funny you mention that: I noticed a while back that actually
it doesn't work well with i386 PAE - presumably looks for an empty 1GB.

Hugh

