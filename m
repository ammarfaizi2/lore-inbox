Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268469AbTBWOT0>; Sun, 23 Feb 2003 09:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268470AbTBWOT0>; Sun, 23 Feb 2003 09:19:26 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:458 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S268469AbTBWOTZ>; Sun, 23 Feb 2003 09:19:25 -0500
Date: Sun, 23 Feb 2003 11:29:21 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Hanna Linder <hannal@us.ibm.com>, "" <lse-tech@lists.sourceforge.net>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <m1smufn7xu.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.50L.0302231126380.2206-100000@imladris.surriel.com>
References: <96700000.1045871294@w-hlinder> <m1smufn7xu.fsf@frodo.biederman.org>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003, Eric W. Biederman wrote:

> Note: rmap chains can be restricted to an arbitrary length, or an
> arbitrary total count trivially. All you have to do is allow a fixed
> limit on the number of people who can map a page simultaneously.
>
> The selection of which chain to unmap can be a bit tricky but is
> relatively straight forward.  Why doesn't someone who is seeing
> this just hack this up?

I'm not sure how useful this feature would be.  Also,
there are a bunch of corner cases in which you cannot
limit the number of processes mapping a page, think
about eg. mlock, nonlinear vmas and anonymous memory.

All in all I suspect that the cost of such a feature
might be higher than any benefits.

cheers,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
