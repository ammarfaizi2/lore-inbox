Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbSKLBcs>; Mon, 11 Nov 2002 20:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266042AbSKLBcs>; Mon, 11 Nov 2002 20:32:48 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:14779 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S266041AbSKLBcr>; Mon, 11 Nov 2002 20:32:47 -0500
Date: Mon, 11 Nov 2002 23:39:17 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: davidm@hpl.hp.com
cc: Mario Smarduch <cms063@email.mot.com>, <linux-ia64@linuxia64.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <15824.915.758329.73126@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44L.0211112337520.3817-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, David Mosberger wrote:
> >>>>> On Mon, 11 Nov 2002 10:29:29 -0600, Mario Smarduch <cms063@email.mot.com> said:
>
>   Mario> I know that on some commercial Unix systems there are ways to
>   Mario> cap the CPU utilization by user/group ids are there such
>   Mario> features/patches available on Linux?

> The kernel patches available from this URL are pretty old (up to
> 2.4.6, as far as I could see), and I'm not sure what the future plans
> for PRM on Linux are.  Perhaps someone else can provide more details.

I'm (slowly) working on a per-user fair scheduler on top of Ingo's
O(1) scheduler.  Slowly because it's a fairly complex thing.

Once that is done it should be possible to change the accounting
to other resource containers and generally have fun assigning
priorities, though that is beyond the scope of what I'm trying to
achieve.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

