Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310298AbSCBDdU>; Fri, 1 Mar 2002 22:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310299AbSCBDdA>; Fri, 1 Mar 2002 22:33:00 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:4446 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310298AbSCBDc6>; Fri, 1 Mar 2002 22:32:58 -0500
Date: Sat, 2 Mar 2002 04:30:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020302043025.R4431@inspiron.random>
In-Reply-To: <20020302030615.G4431@inspiron.random> <E16gzG0-0005qt-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16gzG0-0005qt-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2002 at 02:28:20AM +0000, Alan Cox wrote:
> > On a very lowmem machine the rmap design shouldn't really make a sensible
> > difference, the smaller the amount of mapped VM, the less rmap can make
> > differences, period.
> 
> It makes a big big difference on a low memory box. Try running xfce on
> a 24Mb box with the base 2.4.18, 2.4.18 + rmap12f and 2.4.18+aa. Thats
> a case where aa definitely loses and without other I/O patches being

hmm to fully evaluate this I'd need to have access to the exact two kernel
source tarballs that you compared (a diff against a known vanilla kernel
tree would be fine) and to know the way you measured the difference of
them while xfce was running (nominal performance/responsiveness/whatever?).

Andrea
