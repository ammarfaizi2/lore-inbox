Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131906AbQLQCgf>; Sat, 16 Dec 2000 21:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131936AbQLQCgZ>; Sat, 16 Dec 2000 21:36:25 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:28942 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131906AbQLQCgJ>; Sat, 16 Dec 2000 21:36:09 -0500
Date: Sat, 16 Dec 2000 20:05:24 -0600
To: Joe deBlaquiere <jadb@redhat.com>
Cc: Werner Almesberger <Werner.Almesberger@epfl.ch>, ferret@phonewave.net,
        Alexander Viro <viro@math.psu.edu>, LA Walsh <law@sgi.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
Message-ID: <20001216200524.O3199@cadcamlab.org>
In-Reply-To: <20001215152137.K599@almesberger.net> <Pine.LNX.3.96.1001215090857.16439A-100000@tarot.mentasm.org> <20001215184644.R573@almesberger.net> <3A3A7F25.2050203@redhat.com> <20001215222707.T573@almesberger.net> <3A3AA21F.4060100@redhat.com> <20001216165037.K3199@cadcamlab.org> <3A3C0311.2060205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A3C0311.2060205@redhat.com>; from jadb@redhat.com on Sat, Dec 16, 2000 at 06:04:33PM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Joe deBlaquiere]
> Last I recall you have to at least have newlib around to get through
> the build process of gcc. libgcc doesn't affect the kernel but you
> can't do 'make install' without building it.

Hmmm.  I do not recall needing newlib or anything like it, last time I
built a cross-gcc+binutils.  Perhaps it depends on the target arch.  If
you pick one where the libgcc math functions haven't all been written
yet, you're probably right.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
