Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288638AbSANLnH>; Mon, 14 Jan 2002 06:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289204AbSANLnD>; Mon, 14 Jan 2002 06:43:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17432 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289208AbSANLlx>; Mon, 14 Jan 2002 06:41:53 -0500
Date: Mon, 14 Jan 2002 12:41:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@tech9.net>, jogi@planetzork.ping.de,
        Andrew Morton <akpm@zip.com.au>, Ed Sweetman <ed.sweetman@wmich.edu>,
        yodaiken@fsmlabs.com, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114124156.D10227@athlon.random>
In-Reply-To: <1010946178.11848.14.camel@phantasy> <E16PqMc-0007ks-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16PqMc-0007ks-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jan 13, 2002 at 07:32:18PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 07:32:18PM +0000, Alan Cox wrote:
> > Again, preempt seems to reign supreme.  Where is all the information
> > correlating preempt is inferior?  To be fair, however, we should bench a
> > mini-ll+s test.
> 
> How about some actual latency numbers ?

with an huge rescheduling rate (huge swapout/swapin load) and the
scheduler walking over 100 tasks at each schedule it is insane to
deduct anything from those numbers (-preempt was using O(1)
scheduler!!!!). so please don't make any assumption by just looking at
those numbers.

Andrea
