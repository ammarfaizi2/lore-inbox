Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268029AbTBRVed>; Tue, 18 Feb 2003 16:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268030AbTBRVed>; Tue, 18 Feb 2003 16:34:33 -0500
Received: from tapu.f00f.org ([202.49.232.129]:17295 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S268029AbTBRVe3>;
	Tue, 18 Feb 2003 16:34:29 -0500
Date: Tue, 18 Feb 2003 13:44:31 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
Message-ID: <20030218214431.GA15007@f00f.org>
References: <20030218000304.GA7352@f00f.org> <Pine.LNX.4.44.0302171741250.1754-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302171741250.1754-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 05:42:38PM -0800, Linus Torvalds wrote:

> It would be interesting to hear exactly when the trouble
> started. And if plain 2.5.59 does it (which is unclear from your
> description), but 59-mjb4 doesn't, then that's an interesting data
> point.

After much testing, which is still in progress it would seem that
*maybe* mjb4 does have the problem too, although it's much harder to
hit.  Please note that this is a single data point where for other
kernels I have two or more occurrences of spontaneous reboots.

I've been checking older kernels...  it would seem the problem first
occurs in 2.5.53 (that is 2.5.53 through 2.5.62-bk all reboot for me).
2.5.51 doesn't appear to and thus far neither does 2.5.52.

I say thus far, because the problem usually appears after about 15
minutes of compiling, but it sometimes takes a little longer.  I'm
running 2.5.52 now and after 45 minutes it's still going.


As to what difference it might be between '52 and '53 I have no idea.
I had a quick look and the changes there are considerable.

I've tried different compiles, with and without preempt, and and
without IO-APIC and trimming down the kernel...



  --cw
