Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310280AbSCACE7>; Thu, 28 Feb 2002 21:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310323AbSCACDC>; Thu, 28 Feb 2002 21:03:02 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34524 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310296AbSCACBM>;
	Thu, 28 Feb 2002 21:01:12 -0500
Date: Thu, 28 Feb 2002 21:00:26 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        matthew@hairy.beasts.org, bcrl@redhat.com, david@mysql.com,
        wli@holomorphy.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020228210026.A3070@elinux01.watson.ibm.com>
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au> <20020225100025.A1163@elinux01.watson.ibm.com> <20020227112417.3a302d31.rusty@rustcorp.com.au> <20020227105311.C838@elinux01.watson.ibm.com> <20020228162422.A947@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020228162422.A947@twiddle.net>; from rth@twiddle.net on Thu, Feb 28, 2002 at 04:24:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 04:24:22PM -0800, Richard Henderson wrote:
> On Wed, Feb 27, 2002 at 10:53:11AM -0500, Hubertus Franke wrote:
> > As stated above, I allocate a kernel object <kulock_t> on demand and
> > hash it. This way I don't have to pin any user address. What does everybody
> > think about the merit of this approach versus the pinning approach?
> [...]
> > In your case, can the lock be allocated at different
> > virtual addresses in the various address spaces.
> 
> I think this is a relatively important feature.  It may not be
> possible to use the same virtual address in different processes.
> 
> 
> r~

I think so too. However let me point that Linus's initial recommendation
of a handle, comprised of a kernel pointer and a signature also has
that property.
Just pointing out the merits of the various approaches.

-- Hubertus

