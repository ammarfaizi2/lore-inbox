Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264196AbRFTEIg>; Wed, 20 Jun 2001 00:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264232AbRFTEI1>; Wed, 20 Jun 2001 00:08:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:6436 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264196AbRFTEIP>; Wed, 20 Jun 2001 00:08:15 -0400
Date: Wed, 20 Jun 2001 06:07:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: softirq in pre3 and all linux ports
Message-ID: <20010620060753.B849@athlon.random>
In-Reply-To: <20010619210312.Z11631@athlon.random> <15152.6527.366544.713462@cargo.ozlabs.ibm.com> <20010620055413.A849@athlon.random> <15152.8152.177595.177731@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15152.8152.177595.177731@pizda.ninka.net>; from davem@redhat.com on Tue, Jun 19, 2001 at 09:00:24PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 09:00:24PM -0700, David S. Miller wrote:
> 
> Andrea Arcangeli writes:
>  > I don't have gigabit ethernet so I cannot flood my boxes to death.
>  > But I think it's real, and a softirq marking itself runnable again is
>  > another case to handle without live lockups or starvation.
> 
> I think (still) that you're just moving the problem around and
> not actually changing anything.

something will defintely to change radically if the softirq marks itself
runnable again. but this to me sounds similar to the other one (irq
flood that basically left the softirq pending every time you check it).

Andrea
