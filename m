Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284388AbRLENNw>; Wed, 5 Dec 2001 08:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284385AbRLENNm>; Wed, 5 Dec 2001 08:13:42 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:48138 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284384AbRLENNf>;
	Wed, 5 Dec 2001 08:13:35 -0500
Date: Wed, 5 Dec 2001 11:13:19 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: <lse-tech@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Scalable Statistics Counters
In-Reply-To: <20011205163153.E16315@in.ibm.com>
Message-ID: <Pine.LNX.4.33L.0112051109340.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Ravikiran G Thirumalai wrote:

> Here is a RFC for Scalable Statistics Counters.

> Initial results of micro benchmarking on 3 cpus showed a 65% reduction
> in cpu cycles used to update the proposed statistics counter, over
> global non atomic counter.

I'd use it, if there were a really easy interface to the thing.

This would include both an interface to automagically use it from
the routines where we increase variables to some automagic reporting
in /proc ;)

(it'd be so cool if we could just start using a statistic variable
through some macro and it'd be automatically declared and visible
in /proc ;))

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

