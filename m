Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbRFTMx1>; Wed, 20 Jun 2001 08:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264874AbRFTMxQ>; Wed, 20 Jun 2001 08:53:16 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:54277 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264863AbRFTMxF>; Wed, 20 Jun 2001 08:53:05 -0400
Date: Wed, 20 Jun 2001 14:52:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: softirq in pre3 and all linux ports
Message-ID: <20010620145211.F849@athlon.random>
In-Reply-To: <20010619210312.Z11631@athlon.random> <15152.6527.366544.713462@cargo.ozlabs.ibm.com> <20010620055413.A849@athlon.random> <15152.38018.523162.191937@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15152.38018.523162.191937@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Jun 20, 2001 at 10:18:10PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 10:18:10PM +1000, Paul Mackerras wrote:
> Well if they are relying on having a lot of stack available then those
> places are buggy.  Once the softirq is made pending it can run at any

it's not about having lots of stack available, it's about avoiding
recursion.

Andrea
