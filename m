Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSJWLoW>; Wed, 23 Oct 2002 07:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263785AbSJWLoV>; Wed, 23 Oct 2002 07:44:21 -0400
Received: from [195.223.140.120] ([195.223.140.120]:1036 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263837AbSJWLoT>; Wed, 23 Oct 2002 07:44:19 -0400
Date: Wed, 23 Oct 2002 13:50:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
Message-ID: <20021023115026.GB30182@dualathlon.random>
References: <20021023020534.GJ11242@dualathlon.random> <Pine.LNX.4.44.0210230851170.2360-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210230851170.2360-100000@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 09:19:23AM +0200, Ingo Molnar wrote:
> theory (and i raised that possibility in the discussion), but i'd like to
> see your patch first, because yet another vma tree is quite some
> complexity and it further increases the size of the vma, which is not
> quite a no-cost approach.

it's not another vma tree, furthmore another vma tree indexed by the
hole size wouldn't be able to defragment and it would find the best fit
not the first fit on the left.

Andrea
