Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129997AbQLPXVn>; Sat, 16 Dec 2000 18:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130561AbQLPXVY>; Sat, 16 Dec 2000 18:21:24 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:9486 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129997AbQLPXVR>; Sat, 16 Dec 2000 18:21:17 -0500
Date: Sat, 16 Dec 2000 16:50:37 -0600
To: Joe deBlaquiere <jadb@redhat.com>
Cc: Werner Almesberger <Werner.Almesberger@epfl.ch>, ferret@phonewave.net,
        Alexander Viro <viro@math.psu.edu>, LA Walsh <law@sgi.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
Message-ID: <20001216165037.K3199@cadcamlab.org>
In-Reply-To: <20001215152137.K599@almesberger.net> <Pine.LNX.3.96.1001215090857.16439A-100000@tarot.mentasm.org> <20001215184644.R573@almesberger.net> <3A3A7F25.2050203@redhat.com> <20001215222707.T573@almesberger.net> <3A3AA21F.4060100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A3AA21F.4060100@redhat.com>; from jadb@redhat.com on Fri, Dec 15, 2000 at 04:58:39PM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Joe deBlaquiere]
> might be a good newbie filter... but actually the best thing about it
> is that the compiler people of the work might make generating a
> proper cross-toolchain less difficult by one or two magnitudes...

*WHAT*?  How much less difficult could it possibly get?  This is the
kernel, there is no cross-libc to worry about, so a cross-toolchain is
already down to a pair of CMMIs[1].

I do agree that anyone who can't do *that* should probably be using a
distro-packaged kernel....

Peter

[1] configure-make-make-install
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
