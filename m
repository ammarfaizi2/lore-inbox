Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbRFTEAq>; Wed, 20 Jun 2001 00:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263608AbRFTEAg>; Wed, 20 Jun 2001 00:00:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6787 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262607AbRFTEA3>;
	Wed, 20 Jun 2001 00:00:29 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15152.8152.177595.177731@pizda.ninka.net>
Date: Tue, 19 Jun 2001 21:00:24 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: softirq in pre3 and all linux ports
In-Reply-To: <20010620055413.A849@athlon.random>
In-Reply-To: <20010619210312.Z11631@athlon.random>
	<15152.6527.366544.713462@cargo.ozlabs.ibm.com>
	<20010620055413.A849@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > I don't have gigabit ethernet so I cannot flood my boxes to death.
 > But I think it's real, and a softirq marking itself runnable again is
 > another case to handle without live lockups or starvation.

I think (still) that you're just moving the problem around and
not actually changing anything.

Later,
David S. Miller
davem@redhat.com
