Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269649AbRHOOdJ>; Wed, 15 Aug 2001 10:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269873AbRHOOdA>; Wed, 15 Aug 2001 10:33:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9236 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269649AbRHOOco>; Wed, 15 Aug 2001 10:32:44 -0400
Date: Wed, 15 Aug 2001 16:32:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: thockin@sun.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
Message-ID: <20010815163256.E7382@athlon.random>
In-Reply-To: <20010815021110.F4304@athlon.random> <20010814.171609.75760869.davem@redhat.com> <20010815161318.C7382@athlon.random> <20010815.072419.48797129.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010815.072419.48797129.davem@redhat.com>; from davem@redhat.com on Wed, Aug 15, 2001 at 07:24:19AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 07:24:19AM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Wed, 15 Aug 2001 16:13:18 +0200
> 
>    I was backporting the new version to 2.2 and I noticed that by using
>    NR_OPEN an luser will actually be able to lock into RAM something of the
>    order of the dozen mbytes per process.
> 
> He can do this with page tables too :-)

Since 2.2 we have the free_pgtables to release the pagetables under
unused pgd slots, that was used to work pretty well last time I checked.

Andrea
