Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283390AbRLIMrL>; Sun, 9 Dec 2001 07:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283391AbRLIMrB>; Sun, 9 Dec 2001 07:47:01 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:45319 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S283390AbRLIMq4>;
	Sun, 9 Dec 2001 07:46:56 -0500
Date: Sun, 9 Dec 2001 22:46:13 +1100
From: Anton Blanchard <anton@samba.org>
To: Niels Christiansen <nchr@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011209114613.GA5063@krispykreme>
In-Reply-To: <OF4AC865AC.00ED861C-ON85256B1C.0060D84F@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF4AC865AC.00ED861C-ON85256B1C.0060D84F@raleigh.ibm.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> | > ...which may be true for 4-ways and even 8-ways but when you get to
> | > 32-ways and greater, you start seeing cache problems.  That was the
> | > case on AIX and per-cpu counters was one of the changes that helped
> | > get the spectacular scalability on Regatta.
> |
> | I agree there are large areas of improvement to be done wrt cacheline
> | ping ponging (see my patch in 2.4.17-pre6 for one example), but we
> | should do our own benchmarking and not look at what AIX has been doing.
> 
> Oh, please!  You voiced an opinion.  I presented facts.  Nobody suggested
> we should not measure on Linux.  As a matter of fact, I suggested that
> Kiran does tests on the real counters and he said he would.

Exactly, show me where the current problem is and I will benchmark it on
a 16 way linux/ppc64 machine. Your comments are opinions too unless
you have some figures to back them up :)

Anton
