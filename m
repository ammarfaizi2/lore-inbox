Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbRGKQbT>; Wed, 11 Jul 2001 12:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266742AbRGKQbK>; Wed, 11 Jul 2001 12:31:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13327 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266746AbRGKQay>; Wed, 11 Jul 2001 12:30:54 -0400
Date: Wed, 11 Jul 2001 09:29:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Dave Jones <davej@suse.de>, Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: Discrepancies between /proc/cpuinfo and Dave J's
 x86info
In-Reply-To: <Pine.LNX.4.21.0107111457010.2035-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0107110928520.28216-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jul 2001, Hugh Dickins wrote:

> On Wed, 11 Jul 2001, Dave Jones wrote:
> >
> > This patch (against 247pre6) should keep the cpuinfo in sync with the real
> > state of the CPU..
>
> Am I paranoid?  I feel nervous about "c->cpuid_level--" inferring
> what we expect to happen to it, would prefer to check it (below).

I would much prefer this approach - along with a comment saying "disabling
the serial number may affect the cpuid level".

Done.

		Linus

