Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263608AbRFNSS1>; Thu, 14 Jun 2001 14:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263797AbRFNSST>; Thu, 14 Jun 2001 14:18:19 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:47346 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S263608AbRFNSR7>;
	Thu, 14 Jun 2001 14:17:59 -0400
Date: Thu, 14 Jun 2001 11:17:56 -0700
From: Richard Henderson <rth@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: unregistered changes to the user<->kernel API
Message-ID: <20010614111756.A28888@redhat.com>
In-Reply-To: <20010614191219.A30567@athlon.random> <20010614191634.B30567@athlon.random> <20010614192122.C30567@athlon.random> <20010614103249.A28852@redhat.com> <20010614194757.B715@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010614194757.B715@athlon.random>; from andrea@suse.de on Thu, Jun 14, 2001 at 07:47:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 07:47:57PM +0200, Andrea Arcangeli wrote:
> On Thu, Jun 14, 2001 at 10:32:49AM -0700, Richard Henderson wrote:
> > within glibc, and (2) making these accesses slower since they
> > will be considered O_DIRECT after the change.
> 
> and then read/write will return -EINVAL which is life-threatening.

It would?  I thought it would be ignored at minimum. 

Damnit, I guess we'll have to move it after all.  How
completely irritating.


r~
