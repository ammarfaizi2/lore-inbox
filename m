Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281773AbRKZPaM>; Mon, 26 Nov 2001 10:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281778AbRKZPaD>; Mon, 26 Nov 2001 10:30:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23314 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281773AbRKZP3y>; Mon, 26 Nov 2001 10:29:54 -0500
Date: Mon, 26 Nov 2001 16:29:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
Cc: "'Ken Brownfield'" <brownfld@irridia.com>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: kupdated high load with heavy disk I/O
Message-ID: <20011126162958.O14196@athlon.random>
In-Reply-To: <35F52ABC3317D511A55300D0B73EB8056FCC50@cinshrexc01.shermfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <35F52ABC3317D511A55300D0B73EB8056FCC50@cinshrexc01.shermfin.com>; from ARechenberg@shermanfinancialgroup.com on Mon, Nov 26, 2001 at 10:08:27AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 10:08:27AM -0500, Rechenberg, Andrew wrote:
> Ken,
> 
> The 2.4.15pre7 kernel seems to have fixed my issue with kupdated and 4GB
> RAM.  We did some testing over the weekend and the box was still interactive
> with a load of 7+.  There still seems to be a lot of swapping going on
> though.  I've read from previous threads that 2.4 uses swap more readily
> than 2.2 did, but should it use 10% of my swap and have almost 8MB
> SwapCached?

if it only swapouts at a very slow rate over the time and it never
swapin, then yes it seems sane. You may also give a spin to 2.4.15aa1
that should swap a bit less.

Andrea
