Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284728AbRLEVHS>; Wed, 5 Dec 2001 16:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284709AbRLEVGW>; Wed, 5 Dec 2001 16:06:22 -0500
Received: from bitmover.com ([192.132.92.2]:31874 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284741AbRLEVFt>;
	Wed, 5 Dec 2001 16:05:49 -0500
Date: Wed, 5 Dec 2001 13:05:47 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Message-ID: <20011205130547.X11801@work.bitmover.com>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
	Lars Brinkhoff <lars.spam@nocrew.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011205111115.T11801@work.bitmover.com> <2534997012.1007557344@mbligh.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2534997012.1007557344@mbligh.des.sequent.com>; from Martin.Bligh@us.ibm.com on Wed, Dec 05, 2001 at 01:02:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What I am proposing is to cluster *OS* images on a *single* SMP as a way of
> > avoiding most of the locks necessary to scale up a single OS image on the 
> > same number of CPUs.
> 
> Which, to me, makes the whole thing much less interesting, since there aren't
> SMP systems about that are really large that I know of anyway. Scaling to 
> the size of current SMP systems is a much less difficult problem than scaling
> to the size of NUMA systems.

We don't agree on any of these points.  Scaling to a 16 way SMP pretty much 
ruins the source base, even when it is done by very careful people.

> The main advantage of starting with a single OS image, as I see it, is
> that you have a system that works fine, but performs badly, from the
> outset. 

Hey, I can make one of those :-)

Seriously, I went through this at SGI, that's exactly what they did, and it
was a huge mistake and it never worked.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
