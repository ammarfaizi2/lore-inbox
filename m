Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280012AbRJ3Qrf>; Tue, 30 Oct 2001 11:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280015AbRJ3Qr0>; Tue, 30 Oct 2001 11:47:26 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:7174 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280012AbRJ3QrV>; Tue, 30 Oct 2001 11:47:21 -0500
Date: Tue, 30 Oct 2001 11:47:57 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030114757.D29266@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0110301324410.2963-100000@imladris.surriel.com> <Pine.LNX.4.33.0110300835140.8603-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110300835140.8603-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 08:38:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 08:38:31AM -0800, Linus Torvalds wrote:
> Now, it's not true on _all_ PPC's.
> 
> The sane PPC setups actually have a regular soft-filled TLB, and last I
> saw that actually performed _better_ than the stupid architected hash-
> chains. And for the broken OS's (ie AIX) that wants the hash-chains, you
> can always make the soft-fill TLB do the stupid thing..

User Mode Linux has effectively an infinitely sized TLB.

		-ben
