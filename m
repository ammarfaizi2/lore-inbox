Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282301AbRK2Cm5>; Wed, 28 Nov 2001 21:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282306AbRK2Cmr>; Wed, 28 Nov 2001 21:42:47 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14402 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282302AbRK2Cmj>; Wed, 28 Nov 2001 21:42:39 -0500
Date: Thu, 29 Nov 2001 03:43:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeremy Puhlman <jpuhlman@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Google Test and 2.4.16
Message-ID: <20011129034300.H1465@athlon.random>
In-Reply-To: <3C0542F3.5A9F0EAA@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C0542F3.5A9F0EAA@mvista.com>; from jpuhlman@mvista.com on Wed, Nov 28, 2001 at 12:02:59PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 12:02:59PM -0800, Jeremy Puhlman wrote:
> Ok yesterday got the google tests running...The machine I ran it on
> was a standard (Old) white box...Athlon k6-450 with 128 MB of
> Ram....Using 256 MB of swap....The google test tries to use an
> adjustable 1/2 terra byte Block size...This is unrealistic for an
> embedded system or my system for that matter..So in trying to tune the
> test to the system it seems they would not run unless the block size
> was less then 60 MB...Not sure what the deal was...I tried turning on
> memory-overcommit but no dice...
> 
> So basically I ran the test once through and every thing went fine...The
> 
> test didn't seem to really stress the system very much...
> 
> So I ran the same program 4 times, concurrently...The system did not
> seem to lose any responsiveness....This did stress the vm system since
> each of the processes were grabbing 60 megs...
> 
> I did find that once the 4 processes finished their runs. I ran one
> more just for fun...Then the system locked up...

this won't happen in 2.4.15aa1.

Andrea
