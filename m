Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132682AbRDUPFT>; Sat, 21 Apr 2001 11:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132684AbRDUPFK>; Sat, 21 Apr 2001 11:05:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14946 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132682AbRDUPEz>; Sat, 21 Apr 2001 11:04:55 -0400
Date: Sat, 21 Apr 2001 17:04:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: rmk@arm.linux.org.uk
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "D . W . Howells" <dhowells@astarte.free-online.co.uk>,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: x86 rwsem in 2.4.4pre[234] are still buggy [was Re: rwsem benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]]
Message-ID: <20010421170433.E17757@athlon.random>
In-Reply-To: <20010421162926.D17757@athlon.random> <200104211437.PAA01945@raistlin.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104211437.PAA01945@raistlin.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Apr 21, 2001 at 03:37:05PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 03:37:05PM +0100, rmk@arm.linux.org.uk wrote:
> Andrea Arcangeli writes:
> > That it is allowed by my generic code that does spin_lock_irq in down_* and
> > spin_lock_irqsave in up_* but it's disallowed by the weaker semantics of the
			      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > generic and x86 semaphores 2.4.4pre[2345] (or + David's last patch).
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Hang on, who's code is in 2.4.4-pre5?  It claims to be Davids, which does
> suffer from the problem I described.

Yes.

Andrea
