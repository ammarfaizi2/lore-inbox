Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSHBMtW>; Fri, 2 Aug 2002 08:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSHBMtW>; Fri, 2 Aug 2002 08:49:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:15879 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313508AbSHBMtV>; Fri, 2 Aug 2002 08:49:21 -0400
Date: Fri, 2 Aug 2002 09:52:19 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ryan Cumming <ryan@completely.kicks-ass.org>
cc: "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>,
       <davidm@napali.hpl.hp.com>, <gh@us.ibm.com>, <akpm@zip.com.au>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       <rohit.seth@intel.com>, <sunil.saxena@intel.com>,
       <asit.k.mallick@intel.com>
Subject: Re: large page patch
In-Reply-To: <200208020205.47308.ryan@completely.kicks-ass.org>
Message-ID: <Pine.LNX.4.44L.0208020951360.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Ryan Cumming wrote:
> On August 2, 2002 01:20, David S. Miller wrote:

> > A "hint" to use superpages?  That's absurd.
>
> What about applications that want fine-grained page aging? 4MB is a tad
> on the course side for most desktop applications.

Of course we wouldn't want to use superpages for VMAs smaller
than, say, 4 of these superpages.

That would fix this problem automagically.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

