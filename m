Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280836AbRLHOv5>; Sat, 8 Dec 2001 09:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280983AbRLHOvr>; Sat, 8 Dec 2001 09:51:47 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:38161 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280836AbRLHOv3>;
	Sat, 8 Dec 2001 09:51:29 -0500
Date: Sun, 9 Dec 2001 00:46:22 +1100
From: Anton Blanchard <anton@samba.org>
To: Niels Christiansen <nchr@us.ibm.com>
Cc: kiran@linux.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011208134622.GD2418@krispykreme>
In-Reply-To: <OF5920A1C3.B32C93AF-ON85256B1A.005706AC@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5920A1C3.B32C93AF-ON85256B1A.005706AC@raleigh.ibm.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> > There's several things where per cpu data is useful; low frequency
> > statistics is not one of them in my opinion.
> 
> ...which may be true for 4-ways and even 8-ways but when you get to
> 32-ways and greater, you start seeing cache problems.  That was the
> case on AIX and per-cpu counters was one of the changes that helped
> get the spectacular scalability on Regatta.

I agree there are large areas of improvement to be done wrt cacheline
ping ponging (see my patch in 2.4.17-pre6 for one example), but we
should do our own benchmarking and not look at what AIX has been doing.

Anton
(ppc64 Linux Hacker)
