Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270962AbRHOARD>; Tue, 14 Aug 2001 20:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270961AbRHOAQx>; Tue, 14 Aug 2001 20:16:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:4936 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270959AbRHOAQm>; Tue, 14 Aug 2001 20:16:42 -0400
Date: Wed, 15 Aug 2001 02:16:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
Message-ID: <20010815021648.G4304@athlon.random>
In-Reply-To: <E15Wmp0-00056i-00@gondolin.me.apana.org.au> <20010814.154233.98555395.davem@redhat.com> <20010815020303.D4304@athlon.random> <20010814.170620.52165537.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010814.170620.52165537.davem@redhat.com>; from davem@redhat.com on Tue, Aug 14, 2001 at 05:06:20PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 05:06:20PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Wed, 15 Aug 2001 02:03:03 +0200
> 
>    but OTOH the feedback I had was just happy with the 2.4 fix (so I didn't
>    even checked if the 2.4 fix was fully compliant or not..).
> 
> This is why I'm saying there is no practical reason to make
> this change.

Probably there isn't pratical reason agreed.

> The current code can actually improve performance, avoiding needlessly
> scanning fd==-1 entries.

you assume the entries above max_fds are set to -1, while strictly
speaking they don't need to.

Andrea
