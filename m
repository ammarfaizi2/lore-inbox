Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRDPQEC>; Mon, 16 Apr 2001 12:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRDPQDw>; Mon, 16 Apr 2001 12:03:52 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:18766 "EHLO
	macallan.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S131205AbRDPQDm>; Mon, 16 Apr 2001 12:03:42 -0400
From: Walt Drummond <drummond@engr.valinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15067.6084.459899.879345@macallan.engr.valinux.com>
Date: Mon, 16 Apr 2001 09:03:16 -0700
To: george anzinger <george@mvista.com>
Cc: drummond@engr.valinux.com, Hubertus Franke <frankeh@us.ibm.com>,
        mingo@elte.hu, Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Bug in sys_sched_yield
In-Reply-To: <3AD5E676.CF1C1684@mvista.com>
In-Reply-To: <OFC3243AAE.31877E4B-ON85256A2B.006AE9C3@pok.ibm.com>
	<3AD5D311.5BFE39A6@mvista.com>
	<15061.56474.247739.99673@macallan.engr.valinux.com>
	<3AD5E676.CF1C1684@mvista.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Reply-To: drummond@engr.valinux.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger writes:
> All that is cool.  Still, most places we don't really address the
> processor, so the logical cpu number is all we need.  Places like
> sched_yield, for example, should be using this, not the actual number,
> which IMO should only be used when, for some reason, we NEED the hard
> address of the cpu.  I don't think this ever has to leak out to the
> common kernel code, or am i missing something here.

No your not, I was.  I completely misinterpreted your question.
Sorry about that.

Hubertus and Kanoj have provided the answer I should have given.

--Walt
