Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136055AbRD0Oag>; Fri, 27 Apr 2001 10:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136050AbRD0Oa0>; Fri, 27 Apr 2001 10:30:26 -0400
Received: from ns.suse.de ([213.95.15.193]:44559 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136045AbRD0OaI>;
	Fri, 27 Apr 2001 10:30:08 -0400
Date: Fri, 27 Apr 2001 16:29:03 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010427162903.A12942@gruyere.muc.suse.de>
In-Reply-To: <Pine.GSO.4.21.0104261554050.15385-100000@weyl.math.psu.edu> <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Apr 26, 2001 at 01:08:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 01:08:25PM -0700, Linus Torvalds wrote:
> Note that I think all these arguments are fairly bogus.  Doing things like
> "dump" on a live filesystem is stupid and dangerous (in my opinion it is
> stupid and dangerous to use "dump" at _all_, but that's a whole 'nother
> discussion in itself), and there really are no valid uses for opening a
> block device that is already mounted. More importantly, I don't think
> anybody actually does.

You can use LVM snapshot volumes to do it safely.

-Andi
