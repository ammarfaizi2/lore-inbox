Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262325AbREUB7G>; Sun, 20 May 2001 21:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262330AbREUB64>; Sun, 20 May 2001 21:58:56 -0400
Received: from are.twiddle.net ([64.81.246.98]:14598 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262325AbREUB6j>;
	Sun, 20 May 2001 21:58:39 -0400
Date: Sun, 20 May 2001 18:58:21 -0700
From: Richard Henderson <rth@twiddle.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520185821.B19096@twiddle.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Andrew Morton <andrewm@uow.edu.au>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru> <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random> <20010520181803.I18119@athlon.random> <15112.26992.591864.905111@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15112.26992.591864.905111@pizda.ninka.net>; from davem@redhat.com on Sun, May 20, 2001 at 06:03:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 06:03:44PM -0700, David S. Miller wrote:
> But for the time being, everyone assumes address zero is not valid and
> it shouldn't be too painful to reserve the first page of DMA space
> until we fix this issue.

Indeed, virtually all PCI systems have legacy PeeCee compatibility crap
handing out in low i/o memory, and we don't use the first megabyte or so.


r~
