Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269029AbTBXAdb>; Sun, 23 Feb 2003 19:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269034AbTBXAdb>; Sun, 23 Feb 2003 19:33:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38404 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269029AbTBXAdb>; Sun, 23 Feb 2003 19:33:31 -0500
Date: Sun, 23 Feb 2003 16:40:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: davidm@hpl.hp.com
cc: David Lang <david.lang@digitalinsight.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <15961.20756.474745.44896@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0302231634150.1690-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, David Mosberger wrote:
> 
>    2 GHz Xeon:		701 SPECint
>    1 GHz Itanium 2:	810 SPECint
> 
> That is, Itanium 2 is 15% faster.

Ehh, and this is with how much cache?

Last I saw, the Itanium 2 machines came with 3MB of integrated L3 caches,
and I suspect that whatever 0.13 Itanium numbers you're looking at are
with the new 6MB caches.

So your "apples to apples" comparison isn't exactly that. 

The only thing that is meaningful is "performace at the same time of
general availability". At which point the P4 beats the Itanium 2 senseless
with a 25% higher SpecInt. And last I heard, by the time Itanium 2 is up
at 2GHz, the P4 is apparently going to be at 5GHz, comfortably keeping 
that 25% lead.

			Linus

